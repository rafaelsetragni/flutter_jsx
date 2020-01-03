import 'package:flutter/material.dart';
import 'jsx_node.dart';
import 'jsx_node_text.dart';
import 'jsx_node_element.dart';

class JSXParser {
  @visibleForTesting
  static String parserHtmlPattern =
      '^((?:\\\\.|[^<\\\\]+)*)(<([^\\w<>]*)([\\w]+)?(((\\s*[\\w_-]+(=("([^\\\\"]|\\\\.)+"|\'([^\\\\\']|\\\\.)+\'))?)?)*)\\s*([^\\w<>]*)>)?';

  @visibleForTesting
  static String parserAttrPattern =
      '([\\w-]+)(=("(([^\\\\"]|\\\\.)+)"|\'(([^\\\\\']|\\\\.)+)\')?)?';

  @visibleForTesting
  static final RegExp regExpHtml =
      RegExp(parserHtmlPattern, caseSensitive: false, multiLine: true);

  @visibleForTesting
  static final RegExp regExpAttr =
      RegExp(parserAttrPattern, caseSensitive: false, multiLine: true);

  static List<String> _literalTags = const ['code', 'var', 'pre'];

  static List<String> _selfEnclosedTags = const [
    'input',
    'br',
  ];

  @visibleForTesting
  static extractParameters(JSXNodeElement node, String content) {
    List<Match> matches = regExpAttr.allMatches(content).toList();

    if (matches != null && node != null) {
      for (RegExpMatch match in matches) {
        String name = match.group(1) ?? '',
            value = (match.group(4) ?? '') + (match.group(6) ?? '');

        if (name.isNotEmpty) {
          node.attributes[name] =
              value.replaceAllMapped(RegExp(r'\\(.)'), (match) {
            return match.group(1);
          });
        }
      }
    }

    return node;
  }

  @visibleForTesting
  static List<String> getFirstHtmlElements(String html) {
    if (html == null) {
      return null;
    }

    RegExpMatch match = regExpHtml.firstMatch(html);

    return [
      //fullMatch
      match.group(0) ?? '',
      //beforeText
      match.group(1) ?? '',
      //has html tag
      (match.group(2)?.isEmpty ?? true) ? '' : '<',
      //closing tag
      match.group(3) ?? '',
      //tag name
      match.group(4) ?? '',
      //attributes
      match.group(5) ?? '',
      //self-closing tag
      match.group(12) ?? ''
    ];
  }

  static parse(String html) {
    int deepLevel = 0;
    String literalContent = '';

    _processTree({JSXNode localNode}) {
      if (html.isEmpty) {
        localNode.addNode(JSXNodeText(''));
      }

      List<String> match;
      String fullMatch,
          beforeText,
          hasTag,
          tagName,
          attributes,
          closingTag,
          selfEnclosing;

      do {
        match = getFirstHtmlElements(html);

        if (match != null) {
          fullMatch = match[0];

          if (fullMatch.isNotEmpty) {
            // erase what was already done
            html = html.replaceFirst(fullMatch, '');

            beforeText = match[1];
            hasTag = match[2];
            closingTag = match[3];
            tagName = match[4];
            attributes = match[5];
            selfEnclosing = match[6];

            bool processNode = true;

            // if this element is literal, all his content should returned as single literal text
            if (localNode?.localName != null &&
                _literalTags.contains(localNode.localName)) {
              if (closingTag != '/' || tagName != localNode.localName) {
                literalContent += fullMatch;
                processNode = false;
              } else {
                localNode.addNode(JSXNodeText(
                    literalContent.replaceAllMapped(RegExp(r'\\(.)'), (match) {
                  return match.group(1);
                })));
                literalContent = '';
              }
            }

            if (processNode) {
              JSXNodeElement childElement;

              // Pure text is add first to element
              if (beforeText.isNotEmpty) {
                localNode?.addNode(JSXNodeText(beforeText));
              }

              // Comment tags are ignored
              if (selfEnclosing != '!') {
                if (hasTag.isNotEmpty) {
                  // Closing tags, excluding closed tags which are self closing ones
                  if (closingTag == '/' &&
                      !_selfEnclosedTags.contains(tagName)) {
                    if (localNode is JSXNodeElement) {
                      deepLevel--;

                      // If the tag name are not closing the right dom element, invalidate
                      // the results with null
                      return (localNode.localName != tagName)
                          ? null
                          : localNode;
                    }
                  }

                  // Opening tag
                  else {
                    childElement = JSXNodeElement(tagName);
                    extractParameters(childElement, attributes);
                  }
                }
              }

              // Self-closing tags do not have subtree
              if (childElement != null &&
                  selfEnclosing != '/' &&
                  !_selfEnclosedTags.contains(tagName)) {
                deepLevel++;

                // update his own child element
                childElement.parentNode = localNode;
                childElement = _processTree(localNode: childElement);
              }

              if (childElement != null) {
                localNode?.addNode(childElement);
              }
            }
          }
        }
      } while (localNode != null && fullMatch.isNotEmpty);

      return localNode;
    }

    if (html == null) {
      return null;
    }

    JSXNode bodyNode = JSXNodeElement('body'),
        resultedNode = _processTree(localNode: bodyNode);

    // If levels are not correctly closed, the html is invalid
    if (deepLevel != 0) {
      return null;
    }

    if (resultedNode != null) {
      return resultedNode;
    }

    return null;
  }
}

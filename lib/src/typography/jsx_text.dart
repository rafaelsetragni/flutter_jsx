import 'package:flutter/material.dart';
import 'package:flutter_jsx/src/typography/jsx_converter.dart';
import 'package:flutter_jsx/src/typography/jsx_stylesheet.dart';

import 'jsx_stylesheet.dart';

class JSX extends StatefulWidget {

  /// List containing all the html elements allowed (Recommended to use due to security issues that could rise with filled with user's input)
  final List<String> allowedElements = [];

  /// List of [JSXStylesheet] to be applied on each dom tree node
  final Map<String, JSXStylesheet> stylesheet = {};

  /// List of all [Widget] objects to be replaced over HTML tags
  final Map<String, Widget> widgetNodes = {};

  /// Parser responsible to convert Html string text into [RichText] object
  final JSXConverter jsxConverter = JSXConverter();

  /// Html text to be converted into [RichText] Widget
  final String text;

  /// Amount of pixels to be used on text indent
  final double indentSize = 10.0;

  /// Alignment of the objects inside the box. The elements aligned does not respect the vertical text base line.
  final Alignment alignment;

  /// Internal space which separates the box border from the internal elements
  final EdgeInsets padding;

  /// External space which separates the box border from the outside elements
  final EdgeInsets margin;

  /// Color to be applied into box background (overrides backgroundColor into [BoxDecoration] property
  final Color backgroundColor;

  /// Decoration to be applied into box background and borders (backgroundColor property is overrided by backgroundColor property from this own Class if defined
  final BoxDecoration boxDecoration;

  /// Text style to be applied to the text element
  final TextStyle textStyle;

  /// Determines if the text element should occupy all line or not
  final DisplayLine display;

  /// Determines if the new line characters (\n) should be converted to <br> dom nodes
  final bool renderNewLines;

  /// Determines if the new line characters (\n) should be converted to <br> dom nodes
  final TextOverflow textOverflow;

  JSX(this.text,
      {List<String> allowedElements = const [],
        Map<String, JSXStylesheet> stylesheet = const {},
        Map<String, Widget> widgets = const {},
        this.alignment,
        this.padding,
        this.margin,
        this.backgroundColor,
        this.boxDecoration,
        this.textStyle,
        this.textOverflow,
        this.display = DisplayLine.block,
        this.renderNewLines = false}) {
    if (allowedElements.isNotEmpty) {
      this.allowedElements.clear();
      this.allowedElements.addAll(allowedElements);

      jsxConverter.allowedElements = allowedElements;
    }

    if (widgets.isNotEmpty) {
      this.widgetNodes.clear();
      this.widgetNodes.addAll(widgets);

      jsxConverter.widgets = widgets;
    }

    if (stylesheet.isNotEmpty) {
      this.stylesheet.clear();
      this.stylesheet.addAll(stylesheet);
    }
  }

  @override
  _JSX createState() => _JSX();
}

/// Transform Html text [String] into [RichText] object, combining dom elements with their respective [JSXStylesheet]
class _JSX extends State<JSX> {

  Widget parsedRichText;

  void parseRichText(){

    // TODO implement test of "DefaultTextStyle.of(context).style" before calling it. its trowing errors
    TextStyle inheritedStyle = /*DefaultTextStyle.of(context)?.style ?? */widget.textStyle ?? TextStyle(color: Colors.black);

    if(widget.stylesheet.containsKey('*')){
      widget.stylesheet['*'].textStyle = inheritedStyle.merge(widget.stylesheet['*'].textStyle);
    } else {
      widget.stylesheet.addAll({
        '*': JSXStylesheet(
            textStyle: widget.textStyle
        )
      });
    }

    RichText parsedText = widget.jsxConverter.createElement(
        html: widget.text ?? '',
        renderNewLines: widget.renderNewLines,
        customStylesheet: widget.stylesheet,
        widgets: widget.widgetNodes);

    parsedRichText = Container(
      margin: widget.margin,
      decoration: widget.boxDecoration,
      alignment: widget.alignment,
      padding: widget.padding,
      color: widget.backgroundColor,
      width: widget.display == DisplayLine.block ? double.infinity : null,
      child: Wrap(
        children: [parsedText],
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    parseRichText();
  }

  @override
  Widget build(BuildContext context) {
    return parsedRichText;
  }
}

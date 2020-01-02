import 'package:flutter/material.dart';

import 'jsx_stylesheet.dart';
import 'jsx_typography.dart';

/// Full default stylesheet, based on styles defined on [JSXTypography]
final Map<String, JSXStylesheet> defaultStylesheet = {
  'h1': JSXStylesheet(
      textStyle: JSXTypography.h1, displayLine: DisplayLine.block),
  'h2': JSXStylesheet(
      textStyle: JSXTypography.h2, displayLine: DisplayLine.block),
  'h3': JSXStylesheet(
      textStyle: JSXTypography.h3, displayLine: DisplayLine.block),
  'h4': JSXStylesheet(
      textStyle: JSXTypography.h4, displayLine: DisplayLine.block),
  'h5': JSXStylesheet(
      textStyle: JSXTypography.h5, displayLine: DisplayLine.block),
  'h6': JSXStylesheet(
      textStyle: JSXTypography.h6, displayLine: DisplayLine.block),
  'pre': JSXStylesheet(
      textStyle:
          TextStyle(color: Colors.black, fontSize: 12, fontFamily: 'monospace'),
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
      boxDecoration: BoxDecoration(color: Color.fromARGB(255, 238, 238, 238))),
  'code': JSXStylesheet(
      textStyle:
          TextStyle(color: Colors.black, fontSize: 12, fontFamily: 'monospace'),
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
      boxDecoration: BoxDecoration(color: Color.fromARGB(255, 238, 238, 238))),
  'center':
      JSXStylesheet(textAlign: TextAlign.center, alignment: Alignment.center),
  'mute': JSXStylesheet(opacity: 0.5),
  'u': JSXStylesheet(
      textStyle: TextStyle(
          fontStyle: FontStyle.italic, decoration: TextDecoration.underline),
      displayLine: DisplayLine.inline),
  'p': JSXStylesheet(
    textIndent: 0,
    displayLine: DisplayLine.block,
    padding: EdgeInsets.symmetric(vertical: 5.0),
  ),
  'q': JSXStylesheet(
      textAlign: TextAlign.justify,
      displayLine: DisplayLine.block,
      textStyle: TextStyle(fontStyle: FontStyle.italic),
      padding: EdgeInsets.symmetric(vertical: 5.0),
      margin: EdgeInsets.only(left: 20)),
  'b': JSXStylesheet(textStyle: TextStyle(fontWeight: FontWeight.bold)),
  'i': JSXStylesheet(textStyle: TextStyle(fontStyle: FontStyle.italic)),
  'a': JSXStylesheet(
    textStyle: TextStyle(
      decoration: TextDecoration.underline,
      color: Colors.blueAccent,
      decorationColor: Colors.blueAccent,
    ),
  ),
  '.align-left': JSXStylesheet(
    textAlign: TextAlign.left,
  ),
};

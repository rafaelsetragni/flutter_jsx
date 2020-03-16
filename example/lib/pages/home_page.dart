import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_jsx/flutter_jsx.dart';
import 'package:flutter_jsx_example/layouts/sidebar.dart';
import 'package:flutter_responsive/flutter_responsive.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Home', overflow: TextOverflow.ellipsis),
        ),
        drawer: Sidebar(),
        body: Container(
          color: Color(0xFFCCCCCC),
          child: ListView(
            children: <Widget>[
              ResponsiveContainer(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                backgroundColor: Colors.white,
                maxWidth: mediaQuery.size.width * 0.95,
                children: <Widget>[
                  ResponsiveRow(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    children: <Widget>[

                      // By default, the column occupies the entire row, always
                      ResponsiveCol(
                        children: [
                          JSX(
                            '<Title>'
                                '<span><h1><Logo/></h1><h6>for <i>Flutter</i></h6></span>'
                                '<Wow/>'
                            '</Title>'
                            '<p>This <b>RichText</b> was easily produced and personalized using pure JSX / HTML</p>'
                            '<p>Source code:</p>'
                            '<code>'+
"""
JSX(
  '<Title>'
    '<span><h1><Logo/></h1><h6>for <i>Flutter</i></h6></span>'
    '<Wow/>'
  '</Title>'
  '<p>This <b>RichText</b> was easily produced and personalized using pure JSX / HTML</p>'
  '<p>Source code:</p>'
  '<code><\\/code>'
'</div>'
);
"""
                            +'</code>'
                            '<p>You can also personalize a simple stylesheet using the class '
                            '<pre>JSXStylehseet</pre> for each specific element or replace a specific tag '
                            ' by entire Widget using the property <pre>widgets</pre></p>',
                            display: DisplayLine.block,
                            padding: EdgeInsets.only(bottom: 10),
                            widgets: {
                              'Wow': Image.asset('assets/such_nice_code.jpg'),
                              'Logo': Stack(
                                children: <Widget>[
                                  // Stroked text as border.
                                  Text(
                                    'JSX',
                                    style: TextStyle(
                                      fontSize: 60,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 6
                                        ..color = Colors.black,
                                    ),
                                  ),
                                  // Solid text as fill.
                                  Text(
                                    'JSX',
                                    style: TextStyle(
                                      fontSize: 60,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      foreground: Paint()
                                        ..shader = LinearGradient(
                                          colors: <Color>[Colors.deepOrange.shade200, Colors.deepOrange.shade800],
                                        ).createShader(Rect.fromLTWH(0.0, 0.0, 120.0, 70.0))
                                    ),
                                  ),
                                ],
                              )
                            },
                            stylesheet: {
                              '*': JSXStylesheet(
                                textStyle: TextStyle(color: Colors.black)
                              ),
                              'code': JSXStylesheet(
                                padding: EdgeInsets.all(10.0),
                                margin: EdgeInsets.symmetric(vertical: 20.0)
                              ),
                              'Title': JSXStylesheet(
                                displayLine: DisplayLine.block,
                                margin: EdgeInsets.only(bottom: 25.0),
                                mainAxisAlignment: MainAxisAlignment.spaceAround
                              ),
                              'Wow': JSXStylesheet(
                                width: 150,
                                height: 150,
                                displayLine: DisplayLine.inline
                              ),
                              'span': JSXStylesheet(
                                width: 120,
                                height: 150,
                                displayLine: DisplayLine.inline,
                                alignment: Alignment.center,
                              ),
                              'h1': JSXStylesheet(
                                displayLine: DisplayLine.block,
                              ),
                              'h6': JSXStylesheet(
                                displayLine: DisplayLine.block,
                                textStyle: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)
                              ),
                            },
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20)
                          )
                        ]
                      )

                    ]
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}

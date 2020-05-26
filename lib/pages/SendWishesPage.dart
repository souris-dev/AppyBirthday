import 'dart:async';
import 'dart:math';

import 'package:appy_birthday/backend/ServerServices.dart';
import 'package:appy_birthday/backend/SharedPrefsManager.dart';
import 'package:appy_birthday/widgets/DecoratedTextFlatButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/DiscData.dart';
import '../widgets/TextEditor.dart';

class SendWishesPage extends StatefulWidget {
  @override
  _SendWishesPageState createState() => _SendWishesPageState();
}

class _SendWishesPageState extends State<SendWishesPage> {
  final _discs = <DiscData>[];
  final numberOfDiscs = 44;
  GlobalKey<TextEditorState> keyTextEditor = new GlobalKey<TextEditorState>();

  @override
  void initState() {
    super.initState();
    _makeDiscs();
    Fluttertoast.showToast(msg: 'Use the back button to go to the dashboard.');
    Timer.periodic(Duration(seconds: 5), (timer) => setState(() => _makeDiscs()));
  }

  void _makeDiscs() {
    _discs.clear();
    for (int i = 0; i < numberOfDiscs; i++) {
      _discs.add(DiscData());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.bottom -
                MediaQuery.of(context).padding.top,
            child: Stack(
              children: <Widget>[
                for (final disc in _discs)
                  Positioned.fill(
                    child: AnimatedAlign(
                      duration: Duration(seconds: 5),
                      curve: Curves.easeInOut,
                      alignment: disc.alignment,
                      child: AnimatedContainer(
                        duration: Duration(seconds: 5),
                        decoration: BoxDecoration(
                          color: disc.color,
                          shape: BoxShape.circle,
                        ),
                        height: disc.size,
                        width: disc.size,
                      ),
                    ),
                  ),
                Positioned.fill(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 15),
                        child: Wrap(
                          children: <Widget>[
                            Text(
                              "Send me your wishes!",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(13, 33, 67, 1),
                                fontSize: 18,
                                letterSpacing: 2.3,
                                fontFamily: "SegoePrint",
                                shadows: <Shadow>[
                                  Shadow(
                                    color: Color.fromRGBO(192, 192, 192, 1),
                                    offset: Offset(1.1, 1.1),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Transform.rotate(
                          angle: 1.2 * pi / 180,
                          child: Padding(
                            padding: EdgeInsets.all(30),
                            child: Stack(
                              children: <Widget>[
                                Image.asset(
                                  'assets/raster/TextEditorBg.png',
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                  child: Transform.rotate(
                                    angle: -1.2 * pi / 180,
                                    child: TextEditor(key: keyTextEditor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Align(
                          alignment: Alignment(0.9, 0.9),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
                            child: GestureDetector(
                              onLongPress: () {},
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3194,
                                child: DecoratedTextFlatButtonWithIcon(
                                  onPressed: () {
                                    
                                  },
                                  icon: Icons.send,
                                  text: '  SEND',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

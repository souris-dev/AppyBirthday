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

class _SendWishesPageState extends State<SendWishesPage> with TickerProviderStateMixin {
  final _discs = <DiscData>[];
  final numberOfDiscs = 44;
  GlobalKey<TextEditorState> keyTextEditor = new GlobalKey<TextEditorState>();
  Widget innerChild;

  AnimationController sendAnimationController;
  //AnimationController textboxAnimationController;
  //Animation<double> degreeAnimation;
  Animation<Offset> sendOffsetAnimation;
  Animation<double> sendScaleAnimation;

  bool startedSending = false;

  @override
  void dispose() {
    sendAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _makeDiscs();
    Fluttertoast.showToast(msg: 'Use the back button to go to the dashboard.');
    Timer.periodic(Duration(seconds: 5), (timer) => setState(() => _makeDiscs()));
  }

  // Called after initState(), when with TickerProviderStateMixin
  @override
  void didChangeDependencies() {
    // Need to do the animation setup here
    // because I need the Media size using MediaQuery.of(context) in one of the animations
    // which cannot be accessed during initState()

    sendAnimationController = AnimationController(duration: Duration(milliseconds: 2500), vsync: this);
    sendOffsetAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(MediaQuery.of(context).size.width, -MediaQuery.of(context).size.width), // We want a 45 degrees angle
    ).animate(
      CurvedAnimation(
        parent: sendAnimationController,
        curve: Curves.elasticIn,
      ),
    );

    sendScaleAnimation = Tween<double>(begin: 1, end: 0.3).animate(
      CurvedAnimation(
        curve: Interval(0.8, 1.0, curve: Curves.linearToEaseOut),
        parent: sendAnimationController,
      ),
    );

    /*textboxAnimationController = AnimationController(duration: Duration(seconds: 3), vsync: this);
    degreeAnimation = Tween<double>(begin: 0.2, end: 1.2).animate(
      CurvedAnimation(
        parent: textboxAnimationController,
        curve: Curves.linear,
      ),
    );*/

    sendOffsetAnimation.addListener(() {
      setState(() {});
    });
    // calling setState because value of animation has changed
    sendScaleAnimation.addListener(() {
      setState(() {});
    });
    /*
    degreeAnimation.addListener(() {
      setState(() {});
    });*/

    sendOffsetAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //Fluttertoast.showToast(msg: 'Your message will be sent.');
        Navigator.of(context).pop();
      }
    });

    super.didChangeDependencies();
    //textboxAnimationController.repeat(reverse: true);
  }

  void _makeDiscs() {
    _discs.clear();
    for (int i = 0; i < numberOfDiscs; i++) {
      _discs.add(DiscData());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (startedSending) {
      sendAnimationController.forward();
      innerChild = Center(
        child: Transform(
          transform: Matrix4.translationValues(sendOffsetAnimation.value.dx, sendOffsetAnimation.value.dy, 0)
            ..scale(sendScaleAnimation.value),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Image.asset(
              'assets/raster/SendPlane.png',
              width: MediaQuery.of(context).size.width * 0.605,
              height: MediaQuery.of(context).size.width * 0.605,
            ),
          ),
        ),
      );
    } else {
      innerChild = Transform.rotate(
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
      );
    }

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
                              startedSending ? "Sending..." : "Send me your wishes!",
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
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          transitionBuilder: (child, animationValue) {
                            return ScaleTransition(child: child, scale: animationValue);
                          },
                          child: innerChild,
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
                                  onPressed: () async {
                                    ServerServices.doSend(
                                        keyTextEditor.currentState.textController.text, await SharedPrefsManager.getName());
                                    //textboxAnimationController.stop();
                                    //textboxAnimationController.dispose();
                                    setState(() => startedSending = true);
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

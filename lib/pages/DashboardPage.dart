import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';

import 'package:appy_birthday/backend/ServerServices.dart';
import 'package:appy_birthday/backend/SharedPrefsManager.dart';
import 'package:appy_birthday/pages/EatPage.dart';
import 'package:appy_birthday/pages/RouteAnimations.dart';
import 'package:appy_birthday/widgets/DashboardButton.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/DecoratedTextFlatButton.dart';
import 'package:appy_birthday/widgets/DashboardPageView.dart';
import 'package:appy_birthday/widgets/SignInPageAvatarButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/DiscData.dart';
import 'SendWishesPage.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _discs = <DiscData>[];
  final numberOfDiscs = 44;
  String name = '';
  int longPressedExitTimes = 0;
  AccessCheck accessLevel = AccessCheck.LOW;
  final SignInPageAvatarButtonController avatarDisplayCont = SignInPageAvatarButtonController();

  void getAvatarAccessLevelAndName() async {
    var namae = await SharedPrefsManager.getName();
    var avatarDisplayContAvatar = await SharedPrefsManager.getGenderAvatar();
    var lvl = await SharedPrefsManager.getAccessLevel();

    setState(() {
      this.name = namae;
      this.accessLevel = lvl;
      this.avatarDisplayCont.avatar = avatarDisplayContAvatar;
    });
  }

  @override
  void initState() {
    super.initState();
    _makeDiscs();
    name = '(just a sec)';
    avatarDisplayCont.avatar = Avatar.MALE;
    getAvatarAccessLevelAndName();
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
    return WillPopScope(
      onWillPop: () async {
        Fluttertoast.showToast(msg: 'Press EXIT to log out and quit');
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SizedBox(
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
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 30, bottom: 35),
                          child: SignInPageAvatarButton(
                            isOnSignInPage: false,
                            controller: avatarDisplayCont,
                          ),
                        ),
                      ),
                      Wrap(
                        children: <Widget>[
                          Text(
                            "Welcome, " + name + "!" + "\nThanks for coming!\nTry these" + ((accessLevel == AccessCheck.HIGH) ? " (swipe for more):" : ':'),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(13, 33, 67, 1),
                              fontSize: 15,
                              letterSpacing: 2.1,
                              fontFamily: "SegoePrint",
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: DashboardPageView(
                          children: <Widget>[
                            //Text('Hello!')
                            FittedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: DashboardButton(
                                      onPressed: () {
                                        Navigator.of(context).push(RouteAnimations.createRoute(EatMenuPage()));
                                      },
                                      assetName: "assets/raster/EatBtn.png",
                                      height: MediaQuery.of(context).size.height * (95 / 640),
                                      width: MediaQuery.of(context).size.width * (207 / 360),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: DashboardButton(
                                      onPressed: () {
                                        Navigator.of(context).push(RouteAnimations.createRoute(SendWishesPage()));
                                      },
                                      assetName: "assets/raster/SendWishesBtn.png",
                                      height: MediaQuery.of(context).size.height * (95 / 640),
                                      width: MediaQuery.of(context).size.width * (207 / 360),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (accessLevel == AccessCheck.HIGH)
                              FittedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: DashboardButton(
                                        onPressed: () {
                                          Fluttertoast.showToast(
                                            msg: 'Thanks! Dial my number and give a call!',
                                            backgroundColor: Colors.blue[700],
                                            textColor: Colors.white,
                                          );
                                        },
                                        assetName: "assets/raster/CallMeBtn.png",
                                        height: MediaQuery.of(context).size.height * (95 / 640),
                                        width: MediaQuery.of(context).size.width * (207 / 360),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        child: Align(
                          alignment: Alignment(0.9, 0.9),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
                            child: GestureDetector(
                              onLongPress: () {
                                /*longPressedExitTimes += 1;
                                if (longPressedExitTimes == 1) {
                                  Fluttertoast.showToast(msg: 'Long press again to log out.');
                                } else if (longPressedExitTimes > 1) {
                                  SharedPrefsManager.resetPrefs();
                                  Navigator.of(context).pop();
                                }*/
                              },
                              child: DecoratedTextFlatButton(
                                onPressed: () {
                                  SystemChrome.setSystemUIOverlayStyle(
                                    SystemUiOverlayStyle(
                                      statusBarColor: Colors.black,
                                      statusBarBrightness: Brightness.light,
                                      statusBarIconBrightness: Brightness.light,
                                      systemNavigationBarColor: Colors.black,
                                      systemNavigationBarIconBrightness: Brightness.light,
                                    ),
                                  );
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                      title: Text('Leave?'),
                                      content: Text(
                                          'Do you want to leave?'),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('YES'),
                                          onPressed: () {
                                            SharedPrefsManager.resetPrefs();
                                            exit(0);
                                          },
                                        ),
                                        FlatButton(
                                          child: Text('NO'),
                                          onPressed: () {
                                            Navigator.of(context).pop('dialog');
                                            SystemChrome.setSystemUIOverlayStyle(
                                              SystemUiOverlayStyle(
                                                statusBarColor: Colors.white,
                                                statusBarBrightness: Brightness.dark,
                                                statusBarIconBrightness: Brightness.dark,
                                                systemNavigationBarColor: Colors.white,
                                                systemNavigationBarIconBrightness: Brightness.dark,
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                },
                                text: '  EXIT  ',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

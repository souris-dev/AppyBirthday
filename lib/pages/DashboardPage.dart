import 'dart:async';
import 'dart:io';

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
  final SignInPageAvatarButtonController avatarDisplayCont = SignInPageAvatarButtonController();

  void getAvatarAndName() async {
    var namae = await SharedPrefsManager.getName();
    var avatarDisplayContAvatar = await SharedPrefsManager.getGenderAvatar();

    setState(() {
      this.name = namae;
      print('Setting name as: ' + namae);
      this.avatarDisplayCont.avatar = avatarDisplayContAvatar;
    });
  }

  @override
  void initState() {
    super.initState();
    _makeDiscs();
    name = '(just a sec)';
    avatarDisplayCont.avatar = Avatar.MALE;
    getAvatarAndName();
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
        Fluttertoast.showToast(msg: 'Long press EXIT twice to log out');
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
                            "Welcome, " + name + "!" + "\nThanks for coming!\nTry these (swipe for more):",
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
                            // TODO: Just for testing
                            FittedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
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
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: DashboardButton(
                                      assetName: "assets/raster/EatBtn.png",
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
                                longPressedExitTimes += 1;
                                if (longPressedExitTimes == 1) {
                                  Fluttertoast.showToast(msg: 'Long press again to log out.');
                                } else if (longPressedExitTimes > 1) {
                                  SharedPrefsManager.resetPrefs();
                                  Navigator.of(context).pop();
                                }
                              },
                              child: DecoratedTextFlatButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Leave?'),
                                      content: Text(
                                          'Do you want to leave?\nYou can log out by long-pressing the EXIT button twice.'),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('YES'),
                                          onPressed: () {
                                            exit(0);
                                          },
                                        ),
                                        FlatButton(
                                          child: Text('NO'),
                                          onPressed: () {
                                            Navigator.of(context).pop('dialog');
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

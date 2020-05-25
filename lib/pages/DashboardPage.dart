import 'dart:async';
import 'dart:io';

import 'package:appy_birthday/backend/SharedPrefsManager.dart';
import 'package:appy_birthday/widgets/DashboardButton.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/DecoratedTextFlatButton.dart';
import 'package:appy_birthday/widgets/DashboardPageView.dart';
import 'package:appy_birthday/widgets/SignInPageAvatarButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';

class DiscData {
  static final _rng = Random();

  double size;
  Color color;
  Alignment alignment;

  DiscData() {
    color = Color.fromARGB(
      _rng.nextInt(50),
      _rng.nextInt(255),
      _rng.nextInt(255),
      _rng.nextInt(255),
    );
    size = _rng.nextDouble() * 82 + 10;
    alignment = Alignment(
      _rng.nextDouble() * 2 - 1,
      _rng.nextDouble() * 2 - 1,
    );
  }
}

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
        return true;
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
                            "Hey, " + name + '!' + "\nCongrats, you're in!" + "\nYou could try these out now:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(13, 33, 67, 1),
                              fontSize: 16,
                              letterSpacing: 2.3,
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
                                  GestureDetector(
                                    onTap: () {},
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Image.asset(
                                        "assets/raster/EatBtn.png",
                                        height: MediaQuery.of(context).size.height * (95 / 640),
                                        width: MediaQuery.of(context).size.width * (207 / 360),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Image.asset(
                                        "assets/raster/SendWishesBtn.png",
                                        height: MediaQuery.of(context).size.height * (95 / 640),
                                        width: MediaQuery.of(context).size.width * (207 / 360),
                                      ),
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

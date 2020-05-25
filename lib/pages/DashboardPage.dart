import 'dart:async';

import 'package:appy_birthday/backend/SharedPrefsManager.dart';
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
      _rng.nextInt(100),
      _rng.nextInt(255),
      _rng.nextInt(255),
      _rng.nextInt(255),
    );
    size = _rng.nextDouble() * 60 + 10;
    alignment = Alignment(
      _rng.nextDouble() * 2 - 1,
      _rng.nextDouble() * 2 - 1,
    );
  }
}

class DashbordPage extends StatefulWidget {
  DashbordPage({Key key}) : super(key: key);

  @override
  _DashbordPageState createState() => _DashbordPageState();
}

class _DashbordPageState extends State<DashbordPage> {
  final _discs = <DiscData>[];
  final numberOfDiscs = 32;
  String name = '';
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
    Timer.periodic(Duration(seconds: 2), (timer) => setState(() => _makeDiscs()));
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
        body: Stack(
          children: <Widget>[
            for (final disc in _discs)
              Positioned.fill(
                child: AnimatedAlign(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  alignment: disc.alignment,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
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
                      padding: EdgeInsets.only(top: 30, bottom: 20),
                      child: SignInPageAvatarButton(
                        isOnSignInPage: false,
                        controller: avatarDisplayCont,
                      ),
                    ),
                  ),
                  Wrap(
                    children: <Widget>[
                      Text(
                        "Hey, " + name + '!' + "\nCongrats, you're in!" + "You could try these out now:",
                        style: TextStyle(
                          color: Color(0x0D2143),
                          fontSize: 16,
                          letterSpacing: 2.3,
                          fontFamily: "SegoePrint",
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

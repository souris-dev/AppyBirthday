import 'package:appy_birthday/backend/SharedPrefsManager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum Avatar { MALE, FEMALE, CAT }

class SignInPageAvatarButtonController {
  Avatar avatar = Avatar.MALE;
}

class SignInPageAvatarButton extends StatefulWidget {
  SignInPageAvatarButton({Key key, this.isOnSignInPage = true, this.controller}) : super(key: key);

  final SignInPageAvatarButtonController controller;
  final bool isOnSignInPage;
  @override
  _SignInPageAvatarButtonState createState() => _SignInPageAvatarButtonState();
}

class _SignInPageAvatarButtonState extends State<SignInPageAvatarButton> {
  List<Avatar> avatarsAvailable = [Avatar.MALE, Avatar.FEMALE, Avatar.CAT];
  Map<Avatar, String> avatarAssets = {
    Avatar.MALE: "assets/raster/AvatarMale.png",
    Avatar.FEMALE: "assets/raster/AvatarFemale.png",
    Avatar.CAT: "assets/raster/AvatarCat.png"
  };
  int avaIndex = 0, avaMax = 2;
  int timesSwitched = 0;

  // TODO: Check if the cat unlock works
  void setAvaMax() async {
    if (await SharedPrefsManager.getUnlockedCat()) {
      setState(() => avaMax = 3);
    }
  }

  @override
  void initState() {
    super.initState();
    setAvaMax();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (widget.isOnSignInPage)
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
              ),
            if (widget.isOnSignInPage)
              GestureDetector(
                onLongPress: () async {
                  if (await SharedPrefsManager.getUnlockedCat()) {
                    Fluttertoast.showToast(msg: 'Try switching a few times more');
                  }
                  setState(() {
                    timesSwitched += 1;
                    if (timesSwitched > 3 && avaMax < 3) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('You unlocked a new gender: CAT!'),
                          action: SnackBarAction(
                            label: 'GREAT!',
                            onPressed: () {
                              Scaffold.of(context).hideCurrentSnackBar();
                            },
                          ),
                        ),
                      );
                      avaMax = 3;
                      SharedPrefsManager.setUnlockedCat(true);
                    }
                    avaIndex = (avaIndex + 1) % avaMax;
                    widget.controller.avatar = avatarsAvailable[avaIndex];
                  });
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(avatarAssets[widget.controller.avatar]), // : AssetImage(),
                  radius: MediaQuery.of(context).size.width * 0.207 / 1.6,
                ),
              ),
            if (!widget.isOnSignInPage)
              CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(avatarAssets[widget.controller.avatar]), // : AssetImage(),
                radius: MediaQuery.of(context).size.width * 0.207 / 1.6,
              ),
            if (widget.isOnSignInPage)
              Image.asset(
                "assets/raster/ExplTextAvatar.png",
                height: MediaQuery.of(context).size.height * 0.156,
                width: MediaQuery.of(context).size.width * 0.3055,
              )
          ],
        ),
      ),
    );
  }
}

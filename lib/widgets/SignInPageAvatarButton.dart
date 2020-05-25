import 'package:flutter/material.dart';

enum Avatar { MALE, FEMALE, CAT }

class SignInPageAvatarButtonController {
  Avatar avatar = Avatar.MALE;
}

class SignInPageAvatarButton extends StatefulWidget {
  SignInPageAvatarButton({Key key, this.controller}) : super(key: key);

  final SignInPageAvatarButtonController controller;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width / 4,
            ),
            GestureDetector(
              onLongPress: () {
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

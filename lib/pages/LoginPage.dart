import 'package:appy_birthday/backend/ServerServices.dart';
import 'package:appy_birthday/backend/SharedPrefsManager.dart';
import 'package:appy_birthday/backend/SignInServices.dart';
import 'package:appy_birthday/pages/DashboardPage.dart';
import 'package:appy_birthday/widgets/SignInPageAvatarButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import '../widgets/DecoratedTextFlatButton.dart';
import '../widgets/DecoratedTextRaisedButton.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.isLoggedIn = false}) : super(key: key);

  final Avatar avatar = Avatar.MALE;
  final String name = '';
  final String accessToken = '';
  final bool isLoggedIn;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController accessTokenController = TextEditingController();
  final SignInPageAvatarButtonController signInPageAvatarButtonController = SignInPageAvatarButtonController();
  final FocusNode nameNode = FocusNode();
  final FocusNode accessTokenNode = FocusNode();

  void setUpPreviousVals() async {
    var nameText = await SharedPrefsManager.getName();
    var accessTokenText = await SharedPrefsManager.getAccessToken();
    var avatarTemp = await SharedPrefsManager.getGenderAvatar();

    setState(() {
      nameController.text = nameText;
      accessTokenController.text = accessTokenText;
      signInPageAvatarButtonController.avatar = avatarTemp;
    });
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    accessTokenController.text = widget.accessToken;
    signInPageAvatarButtonController.avatar = widget.avatar;

    if (widget.isLoggedIn) {
      setUpPreviousVals();
    }
  }

  @override
  void dispose() {
    nameNode.dispose();
    accessTokenNode.dispose();
    nameController.dispose();
    accessTokenController.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.bottom -
                MediaQuery.of(context).padding.top,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                  child: Image.asset(
                    "assets/raster/Page3-Illust.png",
                    width: MediaQuery.of(context).size.width * 0.833,
                    height: MediaQuery.of(context).size.height * 0.3125,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(27, 30, 20, 20),
                    child: Container(
                      child: Center(
                        child: Wrap(
                          children: <Widget>[
                            Center(
                              child: Text(
                                widget.isLoggedIn ? "Let's get in!" : 'Tell me about yourself!',
                                style: TextStyle(
                                  color: Color.fromRGBO(13, 33, 67, 1),
                                  fontFamily: 'SegoePrint',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 3.4,
                                  shadows: <Shadow>[
                                    Shadow(
                                      color: Color.fromRGBO(172, 172, 172, 1),
                                      offset: Offset(1.2, 1.2),
                                      blurRadius: 2,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: SignInPageAvatarButton(
                                controller: signInPageAvatarButtonController,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                focusNode: nameNode,
                                controller: nameController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                onSubmitted: (text) {
                                  nameNode.unfocus();
                                  accessTokenNode.requestFocus();
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(20),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Color.fromRGBO(223, 223, 223, 1))),
                                  labelText: 'Name',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Color.fromRGBO(223, 223, 223, 1))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Color.fromRGBO(219, 219, 219, 1))),
                                  labelStyle: TextStyle(color: Color.fromRGBO(64, 0, 190, 1), fontFamily: 'SegoePrint'),
                                ),
                                cursorWidth: 1,
                                cursorColor: Color.fromRGBO(195, 195, 195, 1),
                                style: TextStyle(
                                  color: Color.fromRGBO(13, 33, 67, 1),
                                ),
                              ),
                            ),
                            /*Padding(
                              padding: EdgeInsets.fromLTRB(10, 17, 10, 10),
                              child: TextField(
                                focusNode: accessTokenNode,
                                controller: accessTokenController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(20),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Color.fromRGBO(223, 223, 223, 1))),
                                  labelText: 'Access Pass',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Color.fromRGBO(223, 223, 223, 1))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Color.fromRGBO(219, 219, 219, 1))),
                                  labelStyle: TextStyle(color: Color.fromRGBO(64, 0, 190, 1), fontFamily: 'SegoePrint'),
                                ),
                                cursorWidth: 1,
                                cursorColor: Color.fromRGBO(195, 195, 195, 1),
                                style: TextStyle(
                                  color: Color.fromRGBO(13, 33, 67, 1),
                                ),
                              ),
                            ),*/
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                DecoratedTextFlatButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        title: Text('Access Pass'),
                        content: Padding(
                          padding: EdgeInsets.fromLTRB(10, 17, 10, 10),
                          child: TextField(
                            focusNode: accessTokenNode,
                            controller: accessTokenController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Color.fromRGBO(223, 223, 223, 1))),
                              labelText: 'Access Pass',
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Color.fromRGBO(223, 223, 223, 1))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Color.fromRGBO(219, 219, 219, 1))),
                              labelStyle: TextStyle(color: Color.fromRGBO(64, 0, 190, 1), fontFamily: 'SegoePrint'),
                            ),
                            cursorWidth: 1,
                            cursorColor: Color.fromRGBO(195, 195, 195, 1),
                            style: TextStyle(
                              color: Color.fromRGBO(13, 33, 67, 1),
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          DecoratedTextFlatButton(
                            onPressed: () async {
                              nameNode.unfocus();
                              accessTokenNode.unfocus();
                              FieldEmpty anyEmpty =
                                  SignInServices.checkInputEmpty(nameController, accessTokenController, true);
                              Logger loggr = new Logger();
                              loggr.d((nameController.text == "").toString() +
                                  ' ' +
                                  (accessTokenController.text == "").toString());
                              switch (anyEmpty) {
                                case FieldEmpty.NAME:
                                  Navigator.of(context).pop('dialog');
                                  nameNode.requestFocus();
                                  Fluttertoast.showToast(
                                      msg: 'Forgot your name?', textColor: Colors.white, backgroundColor: Colors.pink[700]);
                                  break;

                                case FieldEmpty.ACCESSTOKEN:
                                  Fluttertoast.showToast(
                                      msg: 'Access pass please.',
                                      textColor: Colors.white,
                                      backgroundColor: Colors.pink[700]);
                                  accessTokenNode.requestFocus();
                                  break;

                                case FieldEmpty.BOTH:
                                  Navigator.of(context).pop('dialog');
                                  Fluttertoast.showToast(
                                      msg: 'Dummy! Fill the fields.',
                                      textColor: Colors.white,
                                      backgroundColor: Colors.pink[700]);
                                  nameNode.requestFocus();
                                  break;

                                default:
                                  break;
                              }

                              if (!(anyEmpty == FieldEmpty.NONE)) {
                                return;
                              }
                              // Business logic for normal Sign-In
                              if (await ServerServices.checkAccessToken(accessTokenController.text) ==
                                  AccessCheck.INVALID_OR_ERROR) {
                                accessTokenNode.requestFocus();
                                return;
                              }

                              String acsTok = accessTokenController.text;
                              accessTokenController.dispose();
                              Navigator.of(context).pop('dialog');

                              SharedPrefsManager.setGender(signInPageAvatarButtonController.avatar).then((val) {
                                SharedPrefsManager.setName(nameController.text).then((value) {
                                  SharedPrefsManager.setAccessToken(acsTok).then((value) {
                                    SharedPrefsManager.setLoggedIn(true).then((value) => Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (context) => DashboardPage())));
                                  });
                                });
                              });
                            },
                            text: ' GO! ',
                          )
                        ],
                      ),
                    );
                  },
                  text: 'GET IN',
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'OR  ',
                        style: TextStyle(
                          color: Color.fromRGBO(13, 33, 67, 1),
                          fontFamily: 'SegoePrint',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3.4,
                          shadows: <Shadow>[
                            Shadow(
                              color: Color.fromRGBO(172, 172, 172, 1),
                              offset: Offset(2, 2),
                              blurRadius: 4,
                            )
                          ],
                        ),
                      ),
                      DecoratedTextRaisedButton(
                        onPressed: () {
                          // Business logic here for Google Sign-In
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              title: Text('Access Pass'),
                              content: Padding(
                                padding: EdgeInsets.fromLTRB(10, 17, 10, 10),
                                child: TextField(
                                  focusNode: accessTokenNode,
                                  controller: accessTokenController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(20),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: Color.fromRGBO(223, 223, 223, 1))),
                                    labelText: 'Access Pass',
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: Color.fromRGBO(223, 223, 223, 1))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: Color.fromRGBO(219, 219, 219, 1))),
                                    labelStyle: TextStyle(color: Color.fromRGBO(64, 0, 190, 1), fontFamily: 'SegoePrint'),
                                  ),
                                  cursorWidth: 1,
                                  cursorColor: Color.fromRGBO(195, 195, 195, 1),
                                  style: TextStyle(
                                    color: Color.fromRGBO(13, 33, 67, 1),
                                  ),
                                ),
                              ),
                              actions: <Widget>[
                                DecoratedTextFlatButton(
                                  onPressed: () async {
                                    //nameNode.unfocus();
                                    accessTokenNode.unfocus();
                                    print('All ok after unfocus!');
                                    if (accessTokenController.text == '') {
                                      Fluttertoast.showToast(
                                        msg: 'Access pass please.',
                                        textColor: Colors.white,
                                        backgroundColor: Colors.pink[700],
                                      );

                                      accessTokenNode.requestFocus();
                                      return;
                                    }
                                    print('All ok before gettext!');
                                    String acsTok = accessTokenController.text;

                                    print('All ok before try signin!');
                                    SignInServices.doGoogleSignOut();
                                    //var success = false;
                                    try {
                                      var signedInStatus = await SignInServices.doGoogleSignIn(acsTok);
                                      if (signedInStatus == SignInStatus.DONE) {
                                        var loggr = Logger();
                                        loggr.d('Success, all ok before push!');
                                        Navigator.of(context).pop('dialog');
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashboardPage()));
                                        await SharedPrefsManager.setGender(signInPageAvatarButtonController.avatar);
                                        await SharedPrefsManager.setName(SignInServices.currentGoogleAccount.displayName);
                                        await SharedPrefsManager.setAccessToken(accessTokenController.text);
                                        await SharedPrefsManager.setLoggedIn(true);
                                      } else if (signedInStatus == SignInStatus.ERROR) {
                                        throw (Exception('SignIn Error'));
                                      } else if (signedInStatus == SignInStatus.INVALID_ACCESS_TOKEN) {
                                        /*Fluttertoast.showToast(
                                          msg: 'Invalid access token!',
                                          textColor: Colors.white,
                                          backgroundColor: Colors.red[800],
                                        );*/
                                        accessTokenNode.requestFocus();
                                        return;
                                      }
                                    } catch (e) {
                                      Fluttertoast.showToast(
                                        msg: 'Google Sign-In failed.',
                                        textColor: Colors.white,
                                        backgroundColor: Colors.red[800],
                                      );

                                      Logger lgr = Logger();
                                      lgr.e('Could not do Google Sign-In');
                                      //print(e.error);
                                    }
                                    /*Logger lgr = Logger();
                                      lgr.d(success);
                                      print(success);
                                      if (success) {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashboardPage()));
                                      }*/
                                  },
                                  text: ' GO! ',
                                )
                              ],
                            ),
                          );
                        },
                        text: 'GOOGLE SIGN-IN',
                      )
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

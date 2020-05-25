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

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController accessTokenController = TextEditingController();
  final SignInPageAvatarButtonController signInPageAvatarButtonController = SignInPageAvatarButtonController();
  final FocusNode nameNode = FocusNode();
  final FocusNode accessTokenNode = FocusNode();

  bool googleSignInInitiated = false;

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
                                'Tell me about yourself!',
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
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 17, 10, 10),
                              child: TextField(
                                focusNode: accessTokenNode,
                                controller: accessTokenController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(20),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Color.fromRGBO(223, 223, 223, 1))),
                                  labelText: 'Access Token',
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                DecoratedTextFlatButton(
                  onPressed: () {
                    FieldEmpty anyEmpty = SignInServices.checkInputEmpty(nameController, accessTokenController, true);
                    Logger loggr = new Logger();
                    loggr.d((nameController.text == "").toString() + ' ' + (accessTokenController.text == "").toString());
                    switch (anyEmpty) {
                      case FieldEmpty.NAME:
                        nameNode.requestFocus();
                        Fluttertoast.showToast(
                            msg: 'Forgot your name?', textColor: Colors.white, backgroundColor: Colors.pink[700]);
                        break;

                      case FieldEmpty.ACCESSTOKEN:
                        Fluttertoast.showToast(
                            msg: 'Access token please.', textColor: Colors.white, backgroundColor: Colors.pink[700]);
                        accessTokenNode.requestFocus();
                        break;

                      case FieldEmpty.BOTH:
                        Fluttertoast.showToast(
                            msg: 'Dummy! Fill the fields.', textColor: Colors.white, backgroundColor: Colors.pink[700]);
                        nameNode.requestFocus();
                        break;

                      default:
                        break;
                    }

                    if (anyEmpty == FieldEmpty.NAME || anyEmpty == FieldEmpty.ACCESSTOKEN) {
                      return;
                    }
                    // Business logic for normal Sign-In
                    if (SignInServices.validateAccessToken(accessTokenController.text) != SignInStatus.VALID_ACCESS_TOKEN) {
                      Fluttertoast.showToast(
                        msg: 'Invalid access token!',
                        textColor: Colors.white,
                        backgroundColor: Colors.red[800],
                      );
                      accessTokenNode.requestFocus();
                      return;
                    }

                    SharedPrefsManager.setGender(signInPageAvatarButtonController.avatar);
                    SharedPrefsManager.setName(nameController.text);
                    SharedPrefsManager.setLoggedIn(true);

                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashboardPage()));
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
                          FieldEmpty anyEmpty = SignInServices.checkInputEmpty(nameController, accessTokenController, true);
                          switch (anyEmpty) {
                            case FieldEmpty.ACCESSTOKEN:
                              Fluttertoast.showToast(
                                msg: 'Access token please.',
                                textColor: Colors.white,
                                backgroundColor: Colors.pink[700],
                              );

                              accessTokenNode.requestFocus();
                              break;

                            case FieldEmpty.BOTH:
                              Fluttertoast.showToast(
                                msg: 'The access token is required.',
                                textColor: Colors.white,
                                backgroundColor: Colors.pink[700],
                              );

                              accessTokenNode.requestFocus();
                              break;

                            default:
                              break;
                          }

                          if (anyEmpty == FieldEmpty.ACCESSTOKEN || anyEmpty == FieldEmpty.BOTH) {
                            return;
                          }

                          googleSignInInitiated = true;
                          SignInServices.doGoogleSignIn(accessTokenController.text).then((value) {
                            if (value == SignInStatus.DONE) {
                              SharedPrefsManager.setGender(signInPageAvatarButtonController.avatar);
                              SharedPrefsManager.setName(SignInServices.currentGoogleAccount.displayName);
                              SharedPrefsManager.setLoggedIn(true);

                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashboardPage()));
                            } else if (value == SignInStatus.ERROR) {
                              throw (Exception('SignIn Error'));
                            } else if (value == SignInStatus.INVALID_ACCESS_TOKEN) {
                              Fluttertoast.showToast(
                                msg: 'Invalid access token!',
                                textColor: Colors.white,
                                backgroundColor: Colors.red[800],
                              );
                              accessTokenNode.requestFocus();
                              return;
                            }
                          }).catchError((e) {
                            Fluttertoast.showToast(
                              msg: 'Google Sign-In failed.',
                              textColor: Colors.white,
                              backgroundColor: Colors.red[800],
                            );

                            Logger lgr = Logger();
                            lgr.e('Could not do Google Sign-In');
                            print(e.error);
                          });

                          // Business logic here for Google Sign-In
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

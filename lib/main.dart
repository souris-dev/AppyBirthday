import 'package:appy_birthday/backend/SharedPrefsManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'pages/Page2.dart';
import 'widgets/DecoratedTextFlatButton.dart';
import 'pages/LoginPage.dart';
import 'package:http/http.dart' as http;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.white, statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.dark),
  );
  runApp(MyApp());
}

class CustomScrollBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: CustomScrollBehaviour(),
          child: child,
        );
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool connectionCheckTried = false;

  void checkConnection() async {
    Fluttertoast.showToast(
      msg: 'Checking connection...',
      backgroundColor: Color.fromRGBO(2, 75, 150, 0.8),
      textColor: Colors.white,
    );
    // Ping server once for fast responses
    var uri = "https://appy-birthday.herokuapp.com";

    try {
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'All okay!',
          backgroundColor: Colors.blue[700],
          textColor: Colors.white,
        );
        setState(() => connectionCheckTried = true);
      } else {
        Fluttertoast.showToast(
          msg: 'Server error!',
          backgroundColor: Colors.pink[800],
          textColor: Colors.white,
        );
        print('Server ERROR code: ' + response.statusCode.toString());
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Connection error! Check internet.',
        backgroundColor: Colors.pink[800],
        textColor: Colors.white,
      );
      print('ERROR WHILE PINGING: ' + e.toString());
    }
    setState(() => connectionCheckTried = true);
  }

  @override
  void initState() {
    super.initState();
    checkConnection();
    SharedPrefsManager.initSharedPrefFields();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 25),
                  child: Image.asset(
                    "assets/raster/Page1-Illust0.png",
                    height: MediaQuery.of(context).size.height * 0.162,
                    width: MediaQuery.of(context).size.width * 0.555,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 8),
                  child: Wrap(
                    children: <Widget>[
                      Text(
                        "to Souris' Birthday Party!",
                        style: TextStyle(
                          color: Color.fromRGBO(66, 1, 197, 1),
                          fontSize: 20,
                          letterSpacing: 2.1,
                          fontFamily: "ChelseaMarket",
                          shadows: <Shadow>[
                            Shadow(color: Color.fromRGBO(217, 217, 217, 1), blurRadius: 15, offset: Offset(4, 4))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Image.asset("assets/raster/Page1-Illust.png"),
                ),
                //height: MediaQuery.of(context).size.height * 0.556,
                //width: MediaQuery.of(context).size.width * 0.78,
              ),
              Container(
                child: Align(
                  alignment: Alignment(0.9, 0.9),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
                    child: DecoratedTextFlatButton(
                      onPressed: () {
                        if (!connectionCheckTried) {
                          Fluttertoast.showToast(
                            msg: 'Please wait, checking connection!',
                            backgroundColor: Colors.pink[700],
                            textColor: Colors.white,
                          );
                        }

                        SharedPrefsManager.isLoggedIn().then((loggedIn) {
                          print('User logged in? ' + loggedIn.toString());
                          if (!loggedIn) {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Page2()));
                          } else {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => LoginPage(
                                  isLoggedIn: true,
                                ),
                              ),
                            );
                          }
                        });
                      },
                      text: 'PROCEED',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

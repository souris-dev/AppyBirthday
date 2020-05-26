import 'package:appy_birthday/backend/SharedPrefsManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/Page2.dart';
import 'widgets/DecoratedTextFlatButton.dart';
import 'pages/LoginPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.white, statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.dark),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  @override
  void initState() {
    super.initState();
    SharedPrefsManager.loadSharedPrefs();
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
                        // TODO: What if user is already logged in?
                        SharedPrefsManager.isLoggedIn().then((loggedIn) {
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

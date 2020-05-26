import 'package:appy_birthday/widgets/DashboardButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class EatMenuPage extends StatefulWidget {
  @override
  _EatMenuPageState createState() => _EatMenuPageState();
}

class _EatMenuPageState extends State<EatMenuPage> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
        );
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
                  Positioned.fill(
                    child: Image.asset(
                      'assets/raster/MenuBg.png',
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.4,
                    left: MediaQuery.of(context).size.width * 0.35,
                    child: Container(
                      child: Align(
                        alignment: Alignment(0, 0),
                        child: Column(
                          children: <Widget>[
                            DashboardButton(
                              assetName: 'assets/raster/EatMenuPizzaBtn.png',
                              onPressed: () {},
                              height: MediaQuery.of(context).size.height * (47 / 640),
                              width: MediaQuery.of(context).size.width * 0.5,
                            ),
                            DashboardButton(
                              assetName: 'assets/raster/EatMenuTeaBtn.png',
                              onPressed: () {},
                              height: MediaQuery.of(context).size.height * (47 / 640),
                              width: MediaQuery.of(context).size.width * 0.5,
                            ),
                            DashboardButton(
                              assetName: 'assets/raster/EatMenuDosaSambarBtn.png',
                              onPressed: () {},
                              height: MediaQuery.of(context).size.height * (47 / 640),
                              width: MediaQuery.of(context).size.width * 0.5,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}

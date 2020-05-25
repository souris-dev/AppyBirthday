import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/DecoratedTextFlatButton.dart';
import 'Page3.dart';

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(25),
              child: Image.asset(
                "assets/raster/Page2-Illust.png",
                width: MediaQuery.of(context).size.width * 0.816,
                height: MediaQuery.of(context).size.height * 0.364,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(27, 30, 20, 20),
                child: Wrap(
                  children: <Widget>[
                    Text(
                      'Hey, buddy!\n ',
                      style: TextStyle(
                          color: Color.fromRGBO(13, 33, 67, 1),
                          fontFamily: 'SegoePrint',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3.4),
                    ),
                    Text(
                      "I'm glad you're here.\nIt'd be great if you identify yourself.\n\nPlease tell me who you are in the next page!\n\nYou can also just use Google sign-in to avoid the hassle.",
                      style: TextStyle(color: Color.fromRGBO(13, 33, 67, 1), fontFamily: 'SegoePrint', letterSpacing: 3.4),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Align(
                alignment: Alignment(0.9, 0.9),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
                  child: DecoratedTextFlatButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Page3()));
                    },
                    text: '  NEXT  ',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

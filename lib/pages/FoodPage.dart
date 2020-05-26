import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:transparent_image/transparent_image.dart';
import '../backend/ServerServices.dart';

class FoodPage extends StatefulWidget {
  FoodPage({Key key, this.foodType}) : super(key: key);

  final Food foodType;
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> with TickerProviderStateMixin {
  Map<Food, String> foodNames = {Food.CF: 'coffee/tea', Food.DOSA: 'dosa', Food.PIZZA: 'pizza'};

  AnimationController dotController;
  Animation<int> numDots;

  @override
  void initState() {
    super.initState();

    dotController = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    numDots = IntTween(begin: 1, end: 4).animate(dotController);

    numDots.addListener(() {
      setState(() {});
    });

    dotController.repeat(reverse: true);
  }

  @override
  void dispose() {
    dotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String text = "Getting your " + foodNames[widget.foodType];
    for (int i = 0; i < numDots.value; i++) {
      text += '.';
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Center(
                child: Wrap(
                  children: <Widget>[
                    Text(
                      text,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[50],
                        fontSize: 15,
                        letterSpacing: 2.1,
                        fontFamily: "SegoePrint",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: FadeInImage.memoryNetwork(
                fit: BoxFit.contain,
                placeholder: kTransparentImage,
                image: ServerServices.serverPointsFood[widget.foodType],
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Text(
                "(Yeah, I know, it's stupid)",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[50],
                  fontSize: 15,
                  letterSpacing: 2.1,
                  fontFamily: "SegoePrint",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

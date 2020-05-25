import 'package:flutter/material.dart';

class DecoratedTextFlatButton extends FlatButton {
  DecoratedTextFlatButton({this.text, this.onPressed})
      : super(
            color: Colors.white,
            onPressed: onPressed,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5), side: BorderSide(color: Color.fromRGBO(223, 223, 223, 1))),
            child: Text(
              text,
              style: TextStyle(
                color: Color.fromRGBO(97, 0, 237, 1),
                fontFamily: 'Roboto',
                letterSpacing: 2.4,
              ),
            ));
  final String text;
  final Function() onPressed;
}

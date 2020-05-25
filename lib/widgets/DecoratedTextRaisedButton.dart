import 'package:flutter/material.dart';

class DecoratedTextRaisedButton extends RaisedButton {
  DecoratedTextRaisedButton({this.text, this.onPressed})
      : super(
            onPressed: onPressed,
            elevation: 3,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            color: Color.fromRGBO(64, 0, 190, 1),
            //shape: RoundedRectangleBorder(
            //    borderRadius: BorderRadius.circular(5), side: BorderSide(color: Color.fromRGBO(223, 223, 223, 1))),
            child: Text(
              text,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontFamily: 'Roboto',
                letterSpacing: 2.4,
              ),
            ));
  final String text;
  final Function() onPressed;
}

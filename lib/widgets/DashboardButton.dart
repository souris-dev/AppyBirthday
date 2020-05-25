import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DashboardButton extends StatefulWidget {
  DashboardButton({Key key, this.arrowRotation = 0, this.title, this.description, this.onPressed}) : super(key: key);

  final double arrowRotation;
  final String title;
  final String description;
  final Function onPressed;

  @override
  _DashboardButtonState createState() => _DashboardButtonState();
}

class _DashboardButtonState extends State<DashboardButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: widget.onPressed,
          child: DottedBorder(
            color: Color(0xB892F9),
            radius: Radius.circular(10),
            strokeWidth: 1,
            dashPattern: [5, 5],
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(6),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text(
                      widget.title,
                      style: TextStyle(color: Color(0x430AC9), fontSize: 14, fontFamily: 'SegoePrint'),
                    ),
                  ),
                  Expanded(
                    child: Wrap(
                      children: <Widget>[
                        Text(
                          widget.description,
                          style: TextStyle(color: Color(0xF75842), fontSize: 11, fontFamily: 'SegoePrint'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: widget.onPressed,
            child: Transform.rotate(
              angle: widget.arrowRotation,
              child: Image.asset(
                'assets/raster/RightArrow_violet',
                height: 10,
                width: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

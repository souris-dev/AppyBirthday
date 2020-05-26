import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DashboardButton extends StatefulWidget {
  DashboardButton({Key key, this.assetName, this.onPressed, this.height, this.width}) : super(key: key);

  final String assetName;
  final Function() onPressed;
  final double height;
  final double width;

  @override
  _DashboardButtonState createState() => _DashboardButtonState();
}

class _DashboardButtonState extends State<DashboardButton> {
  double offsetX = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails det) {
        setState(() => offsetX = 2);
      },
      onTapUp: (TapUpDetails det) {
        setState(() => offsetX = 0);
      },
      onTap: widget.onPressed,
      child: Transform.translate(
        offset: Offset(offsetX, 0),
        child: Image.asset(
          widget.assetName,
          height: widget.height,
          width: widget.width,
        ),
      ),
    );
  }
}

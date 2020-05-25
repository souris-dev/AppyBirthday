import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DashboardPageView extends StatefulWidget {
  DashboardPageView({Key key, this.children}) : super(key: key);

  final List<Widget> children;
  @override
  _DashboardPageViewState createState() => _DashboardPageViewState();
}

class _DashboardPageViewState extends State<DashboardPageView> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Image.asset(
            'assets/raster/LeftArrow_red.png',
            height: 12,
            width: 12,
          ),
        ),
        Expanded(
          child: Stack(
            children: <Widget>[
              Transform.rotate(
                angle: -3,
                child: Opacity(
                  opacity: 0.6,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0xFDD4FF),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              PageView(
                controller: pageController,
                children: widget.children,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Image.asset(
            'assets/raster/RightArrow_red.png',
            height: 12,
            width: 12,
          ),
        ),
      ],
    );
  }
}

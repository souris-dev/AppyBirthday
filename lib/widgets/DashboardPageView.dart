import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';

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
          padding: EdgeInsets.only(left: 10, right: 21),
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
                angle: -3 * pi / 180,
                child: Opacity(
                  opacity: 0.8,
                  child: Container(
                    child: Transform.rotate(
                      angle: 3 * pi / 180,
                    ),
                    height: MediaQuery.of(context).size.height * 0.485,
                    width: MediaQuery.of(context).size.width * 0.775,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color.fromRGBO(233, 212, 255, 1),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              Transform.rotate(
                angle: -3 * pi / 180,
                child: Opacity(
                  opacity: 1,
                  child: Container(
                    child: Transform.rotate(
                      angle: 3 * pi / 180,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 28),
                        child: PageView(
                          controller: pageController,
                          children: widget.children,
                        ),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.485,
                    width: MediaQuery.of(context).size.width * 0.775,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color.fromRGBO(233, 212, 255, 1),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
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

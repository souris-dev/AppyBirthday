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
  double leftBtnOpacity = 0.5;
  double rightBtnOpacity = 1;

  int currPageIndex = 0;
  int numPages;

  @override
  void initState() {
    super.initState();
    numPages = widget.children.length;
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
        GestureDetector(
          onTap: () {
            if (currPageIndex != 0) {
              setState(() {
                currPageIndex -= 1;
                if (currPageIndex < numPages - 1) {
                  rightBtnOpacity = 1;
                }
                if (currPageIndex == 0) {
                  leftBtnOpacity = 0.5;
                }
                pageController.animateToPage(currPageIndex,
                    duration: Duration(milliseconds: 200), curve: Curves.easeOutCubic);
              });
            }
          },
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 21),
            child: Opacity(
              opacity: leftBtnOpacity,
              child: Image.asset(
                'assets/raster/LeftArrow_red.png',
                height: 12,
                width: 12,
              ),
            ),
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
                          onPageChanged: (pageNumber) {
                            currPageIndex = pageNumber;

                            setState(() {
                              if (currPageIndex < numPages - 1) {
                                rightBtnOpacity = 1;
                              }
                              if (currPageIndex == numPages - 1) {
                                rightBtnOpacity = 0.5;
                              }
                              if (currPageIndex == 0) {
                                leftBtnOpacity = 0.5;
                              }
                              if (currPageIndex > 0) {
                                leftBtnOpacity = 1;
                              }
                            });
                          },
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
        GestureDetector(
          onTap: () {
            if (currPageIndex != numPages - 1) {
              setState(() {
                currPageIndex += 1;
                pageController.animateToPage(currPageIndex,
                    duration: Duration(milliseconds: 200), curve: Curves.easeOutCubic);
                if (currPageIndex > 0) {
                  leftBtnOpacity = 1;
                }
                if (currPageIndex == numPages - 1) {
                  rightBtnOpacity = 0.5;
                }
              });
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Opacity(
              opacity: rightBtnOpacity,
              child: Image.asset(
                'assets/raster/RightArrow_red.png',
                height: 12,
                width: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

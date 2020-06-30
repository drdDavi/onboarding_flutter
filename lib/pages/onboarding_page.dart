import 'dart:io';

import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  OnboardingPage({Key key}) : super(key: key);

  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final int _totalPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                _currentPage = page;
                setState(() {});
              },
              children: <Widget>[
                _buildPageContent(
                    isShowImageOnTop: false,
                    image: 'assets/images/onboarding1.png',
                    body: 'Browse the menu and order directly from the application.',
                    color: Color(0xFFFF7252)),
                _buildPageContent(
                    isShowImageOnTop: true,
                    image: 'assets/images/onboarding2.png',
                    body: 'Your order will be immediately collected and sent by our courier ',
                    color: Color(0xFFFFA131)),
                _buildPageContent(
                    isShowImageOnTop: false,
                    image: 'assets/images/onboarding3.png',
                    body: 'Pick up delivery at your door and enjoy groceries',
                    color: Color(0xFF3C60FF))
              ],
            ),
            Positioned(
              bottom: 40,
              left: MediaQuery.of(context).size.width * .05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * .9,
                    child: Row(
                      children: [
                        Container(
                          child: Row(children: [
                            for (int i = 0; i < _totalPages; i++) i == _currentPage ? _buildPageIndicator(true) : _buildPageIndicator(false)
                          ]),
                        ),
                        Spacer(),
                        if (_currentPage != 2)
                          InkWell(
                            onTap: () {
                              _pageController.animateToPage(2, duration: Duration(milliseconds: 400), curve: Curves.linear);
                              setState(() {});
                            },
                            child: Container(
                              height: Platform.isIOS ? 70 : 60,
                              alignment: Alignment.center,
                              child: Text(
                                'Skip',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
                              ),
                            ),
                          ),
                        if (_currentPage == 2)
                          InkWell(
                            onTap: () => print('Get Started Now'),
                            child: Container(
                              height: Platform.isIOS ? 70 : 60,
                              alignment: Alignment.center,
                              child: Text(
                                'Start',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPageContent({String image, String body, Color color, isShowImageOnTop}) {
    return Container(
      decoration: BoxDecoration(color: color),
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (!isShowImageOnTop)
            Column(
              children: [
                Center(
                  child: Image.asset(image),
                ),
                SizedBox(height: 50),
                Text(
                  body,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, height: 1.6, fontWeight: FontWeight.w800, color: Colors.white),
                ),
              ],
            ),
          if (isShowImageOnTop)
            Column(
              children: [
                Text(
                  body,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, height: 1.6, fontWeight: FontWeight.w800, color: Colors.white),
                ),
                SizedBox(height: 50),
                Center(
                  child: Image.asset(image),
                ),
              ],
            )
        ],
      ),
    );
  }

  Widget _buildPageIndicator(bool isCurrentPage) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      height: isCurrentPage ? 18.0 : 10.0,
      width: isCurrentPage ? 18.0 : 10.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.white : Colors.white54,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

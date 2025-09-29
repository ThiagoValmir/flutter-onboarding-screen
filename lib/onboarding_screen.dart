import 'package:flutter/material.dart';
import 'package:flutter_onboarding_screen/home_page.dart';
import 'package:flutter_onboarding_screen/intro_screens/intro_page_1.dart';
import 'package:flutter_onboarding_screen/intro_screens/intro_page_2.dart';
import 'package:flutter_onboarding_screen/intro_screens/intro_page_3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // controller to keep track of which page we are on
  PageController _controller = PageController();

  // keep track if we are on the last page or not
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // page view
          PageView(
            onPageChanged: (value) => setState(() {
              onLastPage = (value == 2);
            }),
            controller: _controller,
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          // dot indicators
          Container(
              alignment: const Alignment(0, 0.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // skip button
                  GestureDetector(
                    child: Text("Skip"),
                    onTap: () {
                      _controller.jumpToPage(2);
                    },
                  ),
                  // dot indicator
                  SmoothPageIndicator(controller: _controller, count: 3),
                  // next button and done button
                  onLastPage
                      ? GestureDetector(
                          child: Text("Done"),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return HomePage();
                            }));
                          },
                        )
                      : GestureDetector(
                          child: Text("Next"),
                          onTap: () {
                            _controller.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                        )
                ],
              ))
        ],
      ),
    );
  }
}

import 'package:capstone1/BasicObject.dart';
import 'package:capstone1/first_page/first_page.dart';
import 'package:capstone1/intro_screens/intro_page_1.dart';
import 'package:capstone1/intro_screens/intro_page_2.dart';
import 'package:capstone1/intro_screens/intro_page_3.dart';
import 'package:capstone1/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({super.key});

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: [IntroPage1(), IntroPage2(), IntroPage3()],
        ),
        Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //skip버튼
                GestureDetector(
                    onTap: () {
                      // Get.to(() => MyPage());
                      Get.offAll(() => FirstPage());
                    },
                    child:
                        TextObject("Skip", Colors.black, 20, FontWeight.w400)),

                //dot indicator
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: SwapEffect(),
                ),
                //next button
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Get.offAll(() => FirstPage());
                        },
                        child: TextObject(
                            "Done", Colors.black, 20, FontWeight.w400))
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: Duration(microseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: TextObject(
                            "Next", Colors.black, 20, FontWeight.w400)),
              ],
            ))
      ]),
    );
  }
}

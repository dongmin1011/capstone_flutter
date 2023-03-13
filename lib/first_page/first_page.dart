import 'dart:math';

import 'package:capstone1/BasicObject.dart';
import 'package:capstone1/TakePicturePage/takepic.dart';
import 'package:capstone1/first_page/MainPage.dart';
import 'package:capstone1/rivAsset/RiveAsset.dart';
import 'package:capstone1/rivAsset/RiveUtils.dart';
import 'package:capstone1/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _MyPageState();
}

class _MyPageState extends State<FirstPage>
    with SingleTickerProviderStateMixin {
  late SMIBool isSideClosed;

  bool isSideMenuClosed = true;

  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xff235883),
      appBar: appbarObject(""),
      drawer: SideView(context),
      // PageView(
      //       controller: PageController(
      //         initialPage: 1, //시작 페이지
      //       ),
      //       children: [
      //         // AnimatedPositioned(
      //         //     duration: Duration(milliseconds: 200),
      //         //     curve: Curves.fastOutSlowIn,
      //         //     width: 288,
      //         //     height: height,
      //         //     // left: isSideMenuClosed ? -288 : 0,
      //         //     left: isSideMenuClosed ? 0 : 220,
      //         //     top: isSideMenuClosed ? 3 : 16,
      //         //     child: SideMenuPage()),
      //         // Transform(
      //         //   alignment: Alignment.center,
      //         //   transform: Matrix4.identity()
      //         //     ..setEntry(3, 2, 0.001)
      //         //     ..rotateY(
      //         //         animation.value - 30 * animation.value * pi / 180),
      //         //   child: Transform.translate(
      //         //       offset: Offset(animation.value * 265, 0),
      //         //       child: Transform.scale(
      //         //           scale: scaleAnimation.value,
      //         //           child: isSideMenuClosed
      //         //               ? MainPage(width: width, height: height)
      //         //               : ClipRRect(
      //         //                   borderRadius:
      //         //                       BorderRadius.all(Radius.circular(25)),
      //         //                   child:
      //         //                       MainPage(width: width, height: height)))),
      //         // ),
      //         Stack(
      //           children: [
      //             Container(
      //                 // duration: Duration(milliseconds: 200),
      //                 // curve: Curves.fastOutSlowIn,
      //                 // width: 288,
      //                 height: height,
      //                 // left: -288,
      //                 child: SideMenuPage()),
      //             Container(
      //               child: Transform(
      //                 alignment: Alignment.center,
      //                 transform: Matrix4.identity()
      //                   ..setEntry(3, 2, 0.001)
      //                   ..rotateY(120 - 50 * animation.value * pi / 180),
      //                 child: Transform.translate(
      //                     offset: Offset(animation.value * 265, 0),
      //                     child: Transform.scale(
      //                         scale: scaleAnimation.value,
      //                         child: ClipRRect(
      //                             borderRadius:
      //                                 BorderRadius.all(Radius.circular(50)),
      //                             child:
      //                                 MainPage(width: width, height: height)))),
      //               ),
      //             )
      //           ],
      //         ),
      //         MainPage(width: width, height: height)
      //       ],
      //     ),
      body: MainPage(width: width, height: height),

      // body: Stack(
      //   children: [
      //     AnimatedPositioned(
      //         duration: Duration(milliseconds: 200),
      //         curve: Curves.fastOutSlowIn,
      //         width: 288,
      //         height: height,
      //         left: isSideMenuClosed ? -288 : 0,
      //         child: SideMenuPage()),
      //     Transform(
      //       alignment: Alignment.center,
      //       transform: Matrix4.identity()
      //         ..setEntry(3, 2, 0.001)
      //         ..rotateY(animation.value - 30 * animation.value * pi / 180),
      //       child: Transform.translate(
      //           offset: Offset(animation.value * 265, 0),
      //           child: Transform.scale(
      //               scale: scaleAnimation.value,
      //               child: isSideMenuClosed
      //                   ? MainPage(width: width, height: height)
      //                   : ClipRRect(
      //                       borderRadius:
      //                           BorderRadius.all(Radius.circular(50)),
      //                       child: MainPage(width: width, height: height)))),
      //     ),
      //     AnimatedPositioned(
      //       duration: Duration(milliseconds: 200),
      //       curve: Curves.fastOutSlowIn,
      //       left: isSideMenuClosed ? 0 : 220,
      //       top: isSideMenuClosed ? 3 : 16,
      //       child: Menubtn(riveOnInit: (artboard) {
      //         // StateMachineController controller = RiveUtils.getRiveController(
      //         //     artboard,
      //         //     stateMachineName: "Morph");
      //         // isSideClosed = controller.findSMI("ToMenu") as SMIBool;
      //         // isSideClosed.value = true;
      //         isSideMenuClosed = true;
      //       }, press: () {
      //         // isSideClosed.value = !isSideClosed.value;
      //         // isSideMenuClosed = !isSideMenuClosed;

      //         if (isSideMenuClosed) {
      //           _animationController.forward();
      //         } else {
      //           _animationController.reverse();
      //         }
      //         isSideMenuClosed = !isSideMenuClosed;
      //         setState(() {
      //           // isSideMenuClosed = isSideClosed.value;
      //         });
      //       }),
      //     )
      //   ],
      // )
    );
  }
}

class Menubtn extends StatelessWidget {
  const Menubtn({
    Key? key,
    required this.press,
    required this.riveOnInit,
  }) : super(key: key);
  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: press,
        child: Container(
          margin: const EdgeInsets.only(left: 20, top: 10),
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, offset: Offset(0, 3), blurRadius: 8)
              ]),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: RiveAnimation.asset(
              "assets/riv/menu4.riv",
              onInit: riveOnInit,
            ),
          ),
        ),
      ),
    );
  }
}



// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<SplashScreen> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.asset(
//       'assets/splash/spash1.mp4',
//     )
//       ..initialize().then((_) => {setState(() {})})
//       ..setVolume(0.0);

//     _playVideo();
//   }

//   void _playVideo() async {
//     _controller.play();

//     await Future.delayed(const Duration(seconds: 3));
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => const MyPage()));
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff235883),
//       body: Center(
//         child: _controller.value.isInitialized
//             ? AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 child: VideoPlayer(_controller),
//               )
//             : Container(),
//       ),
//     );
//   }
// }

// class RPSCustomPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint0 = Paint()
//       ..color = const Color.fromARGB(255, 35, 88, 131)
//       ..style = PaintingStyle.fill
//       ..strokeWidth = 1;

//     Path path0 = Path();
//     path0.moveTo(0, size.height * 0.5080000);
//     path0.quadraticBezierTo(size.width * 0.0975000, size.height * 0.3040000,
//         size.width * 0.2470000, size.height * 0.2980000);
//     path0.quadraticBezierTo(size.width * 0.3840000, size.height * 0.3005000,
//         size.width * 0.5010000, size.height * 0.5020000);
//     path0.quadraticBezierTo(size.width * 0.6050000, size.height * 0.6730000,
//         size.width * 0.7510000, size.height * 0.6700000);
//     path0.quadraticBezierTo(size.width * 0.8982500, size.height * 0.6735000,
//         size.width, size.height * 0.4620000);
//     path0.lineTo(size.width, size.height);
//     path0.lineTo(0, size.height);

//     canvas.drawPath(path0, paint0);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
// Container getBackGround() {
//   return Container(
//     width: 410,
//     height: 852,
//     color: Colors.white,
//     padding: const EdgeInsets.only(
//       bottom: 460,
//     ),
//     child: Row(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.end,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           width: 380,
//           height: double.infinity,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Color(0xffe49696),
//           ),
//         ),
//         SizedBox(width: 246.80),
//         Container(
//           width: 380,
//           height: double.infinity,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Color(0xffee5d5d),
//           ),
//         ),
//         SizedBox(width: 246.80),
//         Container(
//           width: 383,
//           height: double.infinity,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Color(0xffe49696),
//           ),
//         ),
//         SizedBox(width: 246.80),
//         Container(
//           width: 383,
//           height: double.infinity,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Color(0xffee5d5d),
//           ),
//         ),
//         SizedBox(width: 246.80),
//         Transform.rotate(
//           angle: -3.14,
//           child: Container(
//             width: 322,
//             height: 332,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Color(0xffe49696),
//             ),
//           ),
//         ),
//         SizedBox(width: 246.80),
//         Transform.rotate(
//           angle: -3.14,
//           child: Container(
//             width: 322,
//             height: 332,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Color(0xffee5d5d),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

import 'package:capstone1/HiddenDrawer.dart';
import 'package:capstone1/StoreInfo.dart';
import 'package:capstone1/TakePicturePage/takepic.dart';
import 'package:capstone1/first_page/first_page.dart';
import 'package:capstone1/intro_screens/OnBoardingScreen.dart';
import 'package:capstone1/rivAsset/RiveAsset.dart';
import 'package:capstone1/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        // initialRoute: '/',
        // routes: {
        //   '/': (context) => MyPage(),
        //   //  '/picture': (context) => takepic(),
        // },
        title: 'Appbar',
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => FirstPage()),
          GetPage(name: '/first', page: () => takepic()),
          // GetPage(name: '/second', page: ()=>()),
        ],
        theme: ThemeData(primaryColor: Color(0xff235883)),
        home: FirstPage());
  }
}

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: Duration(seconds: (1)),
//       vsync: this,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Lottie.asset(
//         'assets/lottie/programmer.json',
//         controller: _controller,
//         height: MediaQuery.of(context).size.height * 1,
//         animate: true,
//         onLoaded: (composition) {
//           _controller
//             ..duration = composition.duration
//             ..forward().whenComplete(() => Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => MyPage()),
//                 ));
//         },
//       ),
//     );
//   }
// }


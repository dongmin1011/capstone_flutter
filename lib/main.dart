import 'dart:io';

import 'package:capstone1/HiddenDrawer.dart';
import 'package:capstone1/StoreInfo.dart';
import 'package:capstone1/TakePicturePage/takepic.dart';
import 'package:capstone1/first_page/first_page.dart';
import 'package:capstone1/intro_screens/OnBoardingScreen.dart';
import 'package:capstone1/rivAsset/RiveAsset.dart';
import 'package:capstone1/side_menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

// import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)..maxConnectionsPerHost = 5;
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: FirebaseOptions(apiKey: ),
// );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // KakaoSdk.init(nativeAppKey: '4729c96c97b19ccdd163431cfa729d45');
  KakaoSdk.init(nativeAppKey: '4729c96c97b19ccdd163431cfa729d45');

  // HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final storage = FlutterSecureStorage();
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
      home: FirstPage(),
    );
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


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:capstone1/takepic.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => MyPage(),
      //   //  '/picture': (context) => takepic(),
      // },
      title: 'Appbar',

      theme: ThemeData(primaryColor: Color(0xff235883)),
      home: MyPage(),
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

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'FIND STORE',
            //      style: TextStyle(color: Colors.black38),
          ),
          //   backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 5.0,
        ),
        drawer: SideView(),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Lottie.asset(
              'assets/lottie/programmer.json',
              height: 300,
            ),
            ElevatedButton(
              child: Text('사진찍으러 가기'),
              onPressed: () {
                //   Navigator.pushNamed(context, '/picture');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => takepic()));
              },
            ),
          ]),
        ));
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

Drawer SideView() {
  return Drawer(
    child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      UserAccountsDrawerHeader(
        currentAccountPicture: CircleAvatar(
          backgroundImage:
              AssetImage('assets/user.png'), //이미지 삽입할때 pubspec에셋확인하기
          backgroundColor: Colors.white,
        ),
        otherAccountsPictures: [
          CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/robot.png'),
          )
        ],
        accountName: Text("이름"),
        accountEmail: Text('이메일'),
        onDetailsPressed: () {
          print('arrow is clicked');
        },
        decoration: BoxDecoration(
            color: Colors.red[200],
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0))),
      ),
      ListTile(
        leading: Icon(
          Icons.home,
          color: Colors.grey[850],
        ),
        title: Text('home'),
        onTap: () {
          print('home is clicked');
        },
        trailing: Icon(Icons.add),
      ),
      ListTile(
        leading: Icon(
          Icons.settings,
          color: Colors.grey[850],
        ),
        title: Text('Setting'),
        onTap: () {
          print('Setting is clicked');
        },
        trailing: Icon(Icons.add),
      ),
      ListTile(
        leading: Icon(
          Icons.question_answer,
          color: Colors.grey[850],
        ),
        title: Text('Q&A'),
        onTap: () {
          print('Q&A is clicked');
        },
        trailing: Icon(Icons.add),
      ),
    ]),
  );
}

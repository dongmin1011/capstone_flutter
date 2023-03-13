import 'dart:convert';

import 'package:capstone1/BasicObject.dart';
import 'package:capstone1/StoreInfo.dart';
import 'package:capstone1/TakePicturePage/takepic.dart';
import 'package:capstone1/community/communityPage.dart';
import 'package:capstone1/loginPage/loginPage.dart';
import 'package:capstone1/user/UserInfo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static final storage = FlutterSecureStorage();
  final RxBool isActive = false.obs;

  User? currentUser;
  // 현재 로그인한 사용자 정보를 가져오는 함수
  Future<User?> getCurrentUser() async {
    final isLoggedIn = await storage.read(key: 'jwtToken');
    if (isLoggedIn != null && isLoggedIn == 'true') {
      final id = await storage.read(key: 'loginId');
      // final pw = await storage.read(key: 'password');
      final username = await storage.read(key: 'nickname');
      if (id != null && username != null) {
        currentUser = User(loginId: id, password: "", nickname: username);
        return currentUser;
      }
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _asyncMethod();
    });
    // _asyncMethod();
  }

  String id = '';
  String nickName = '';
  bool isLogin = false;

  _asyncMethod() async {
    // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
    // 데이터가 없을때는 null을 반환
    var userInfo = await storage.read(key: 'jwtToken');

    // user의 정보가 있다면 로그인 후 들어가는 첫 페이지로 넘어가게 합니다.
    if (userInfo != null) {
      print("로그인 성공");
      print(userInfo);
      // print(User.fromJson(userInfo));
      // id = json.decode(userInfo[2].toString());
      isLogin = true;
      getCurrentUser();
      print(currentUser!.getId());

      // Get.to(takepic());
      // Navigator.pushNamed(context, '/main');
    } else {
      print("로그인 필요");
      isLogin = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     fit: BoxFit.cover,
      //     image: AssetImage('assets/background/background.png'), // 배경 이미지
      //   ),
      // ),
      // body: SingleChildScrollView(
      // physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          backgroundImage(widget.width, widget.height),
          SingleChildScrollView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Center(
              child: Column(
                children: [
                  title("FIND STORE", widget.width, widget.height),

                  SizedBox(
                    height: 20,
                  ),
                  // Lottie.asset(
                  //   'assets/lottie/programmer.json',
                  //   height: 200,
                  // ),
                  userInfoWidget(context),

                  SizedBox(
                    height: 30,
                  ),
                  MainPageInfo(width: widget.width, height: widget.height),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      children: [
                        InkWell(
                            onTap: (() async {
                              Get.to(() => CommunityPage(response: "hi"));
                              // print("hi");
                              // var dio = new Dio();
                              // try {
                              //   var response = await dio.get(
                              //     "http://221.144.8.235:8080/basic/community",
                              //   );
                              //   if (response.statusCode == 200) {
                              //     Get.to(() =>
                              //         CommunityPage(response: response.data));
                              //   }
                              // } catch (e) {
                              //   Exception(e);
                              // } finally {
                              //   dio.close();
                              // }
                            }),
                            child: Hero(
                              // tag: "tagHero",
                              tag: "community",
                              child: Container(
                                  width: widget.width * 0.7,
                                  // height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.grey,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black54,
                                          //   blurRadius: 100.0,
                                          blurRadius: 5.0,
                                          offset: Offset(0, 7))
                                    ],
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 5,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 50,
                                        child: Lottie.asset(
                                            "assets/lottie/communication.json"),
                                      ),
                                      SizedBox(
                                          // width: widget.width * 0.6,

                                          child: TextObject(
                                              "커뮤니티",
                                              Colors.white,
                                              30,
                                              FontWeight.bold)),
                                    ],
                                  )),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                            onTap: () => Get.to(() => takepic()),
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) => takepic())),
                            child: Hero(
                              tag: "tagHero",
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(999),
                                    color: Colors.black,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black54,
                                          //   blurRadius: 100.0,
                                          blurRadius: 5.0,
                                          offset: Offset(0, 10))
                                    ],
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 11,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Container(
                                            width: widget.width * 0.6,
                                            height: 40,
                                            child: TextObject(
                                                "사진 찍기",
                                                Colors.white,
                                                30,
                                                FontWeight.bold)),
                                      ),
                                    ],
                                  )),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container userInfoWidget(BuildContext context) {
    return Container(
        // color: Colors.white,

        width: widget.width * 0.9,
        height: widget.height * 0.2,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 3),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 20,
              )
            ]),
        child: Column(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                width: widget.width * 0.8,
                height: widget.height * 0.06,
                child: TextObject("사용자 정보", Colors.black, 25, FontWeight.bold)),
            Container(
              width: widget.width * 0.8,
              child: Row(
                children: [
                  Container(
                      // alignment: Alignment.centerLeft,
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50))),
                      child: GestureDetector(
                        onTap: () {
                          print("go to loginPage");
                          openLoginPage(context);
                        },
                        child: Lottie.asset(
                          'assets/lottie/programmer.json',
                          // height: 200,
                        ),
                      )),
                  Container(
                    width: widget.width * 0.50,
                    height: widget.height * 0.1,
                    // decoration: BoxDecoration(
                    //     border: Border.all(color: Colors.black)),
                    child: !isLogin
                        ? Column(children: [
                            TextObject("로그인 상태가 아닙니다.", Colors.black, 15,
                                FontWeight.w400)
                          ])
                        : Column(
                            children: [
                              TextObject(
                                  "로그인", Colors.black, 15, FontWeight.w400),
                              TextObject(currentUser!.getId(), Colors.black, 15,
                                  FontWeight.w400),
                              TextObject(currentUser!.getNickname(),
                                  Colors.black, 15, FontWeight.w400),
                            ],
                          ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 40,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      // border:
                      //     Border.all(color: Colors.black)
                    ),
                    child: GestureDetector(
                      onTap: () {
                        print("go to loginPage");
                        openLoginPage(context);
                      },
                      child:
                          TextObject("로그인", Colors.black, 23, FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class MainPageInfo extends StatefulWidget {
  MainPageInfo({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  State<MainPageInfo> createState() => _MainPageInfoState();
}

class _MainPageInfoState extends State<MainPageInfo> {
  late PageController _controller;
  static dynamic currentPageValue = 0.0;
  late List pageViewItem;
  // late int _currentIndex;

  // void onPageChanged(int index) {
  //   setState(() {
  //     _currentIndex = index;
  //     // _controller =
  //     //     PageController(initialPage: _currentIndex, viewportFraction: 0.8);
  //   });
  // }
  // @override
  // bool get wantKeepAlive => true;
  // PageController getPageControll() {
  //   return _controller;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _currentIndex = 0;
    _controller = PageController(initialPage: -1, viewportFraction: 0.8);
    _controller.addListener(() {
      setState(() {
        currentPageValue = _controller.page;
      });
    });
  }

// Widget page(var pageno, Color color) {
//   return Container(
//     width: double.infinity,
//     height: double.infinity,
//     color: color,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Icon(
//           Icons.pages,
//           color: Colors.white,
//         ),
//         Text("${pageno}, Swipe Right or left"),
//         Icon(Icons.arrow_right, color: Colors.white),
//       ],
//     ),
//   );
// }
  Widget pageView() {
    return PageView.builder(
        // onPageChanged: onPageChanged,
        itemCount: pageViewItem.length,
        scrollDirection: Axis.horizontal,
        controller: _controller,
        itemBuilder: (context, position) {
          return Transform(
            transform: Matrix4.identity()..rotateX(currentPageValue - position),
            child: pageViewItem[position],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    pageViewItem = [pageObject(1), pageObject(2), pageObject(3)];
    return Container(
      height: widget.height * 0.3,
      width: widget.width,
      child: Stack(
        children: [
          pageView(),
          Container(
            alignment: Alignment(0, 0.75),

            //dot indicator
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: SwapEffect(),
            ),
            //next button
          )
        ],
      ),
    );
  }

  Widget pageObject(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 10, right: 10),
      child: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                    offset: const Offset(0, 7)),
              ],
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: Container(
            // color: Colors.amberAccent,
            // alignment: Alignment.topLeft,
            child: (index == 1)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        TextObject(
                          "",
                          Colors.black,
                          20,
                          FontWeight.bold,
                        ),
                        // TextObject(
                        //     "원하는 가게를 찾는다!", Colors.black, 20, FontWeight.bold,
                        //     center: false)
                      ])
                : index == 2
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            TextObject(
                                "안녕 두번째페이지", Colors.red, 20, FontWeight.bold)
                          ])
                    : index == 3
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                TextObject("안녕 세번째페이지", Colors.green, 20,
                                    FontWeight.bold)
                              ])
                        : Text("NULL"),
          )),
    );
  }
}

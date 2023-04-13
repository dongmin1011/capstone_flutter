import 'package:capstone1/BasicObject.dart';
import 'package:capstone1/MyInfoPage/MyInfoWidget.dart';
import 'package:capstone1/TakePicturePage/takepic.dart';
import 'package:capstone1/Token/token.dart';
import 'package:capstone1/community/communityPage.dart';
import 'package:capstone1/first_page/first_page.dart';
import 'package:capstone1/loginPage/loginPage.dart';
import 'package:capstone1/loginPage/signUpPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../first_page/MainPage.dart';

class SideView extends StatelessWidget {
  const SideView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainPageController>(
        builder: (controller) => Drawer(
              child: ListView(padding: EdgeInsets.zero, children: <Widget>[
                DrawerHeader(
                    child: FutureBuilder(
                        future: getToken(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return loginComplete(context, snapshot.data);
                          } else {
                            return notLogin(context);
                          }
                        }),
                    decoration: BoxDecoration(
                        color: Colors.red[200],
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40)))),
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 20, bottom: 10),
                  child: Text(
                    "메뉴 목록",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.black54),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Divider(
                    color: Colors.black54,
                    height: 1,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.grey[850],
                  ),
                  title: TextObject("Home", Colors.black, 15, FontWeight.w300,
                      center: false),
                  onTap: () {
                    print('home is clicked');
                    // Navigator.of(context).pop();
                    // Get.back();
                    Get.offAll(() => FirstPage());
                  },
                  trailing: Icon(Icons.add),
                ),
                ListTile(
                  leading: Icon(
                    Icons.camera,
                    color: Colors.grey[850],
                  ),
                  title: TextObject(
                      "Take a Picture", Colors.black, 15, FontWeight.w300,
                      center: false),
                  onTap: () {
                    Get.back();
                    Get.to(() => takepic());
                    print('Picture is clicked');
                  },
                  trailing: Icon(Icons.add),
                ),
                ListTile(
                  leading: Icon(
                    Icons.people,
                    color: Colors.grey[850],
                  ),
                  title: TextObject("커뮤니티", Colors.black, 15, FontWeight.w300,
                      center: false),
                  onTap: () {
                    Get.back();
                    Get.to(() => CommunityPage(response: "test"));
                    print('community is clicked');
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
            ));
  }
}

// Drawer SideView(BuildContext context) {
//   return
// }

Widget loginComplete(BuildContext context, data) {
  final MainPageController _myController = Get.put(MainPageController());
  return Container(
    // decoration: BoxDecoration(border: Border.all()),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextObject("사용자 정보", Colors.black, 20, FontWeight.bold),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 150,
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50))),
                    child: GestureDetector(
                      child: Lottie.asset(
                        'assets/lottie/programmer.json',
                        // height: 200,
                      ), //이미지 삽입할때 pubspec에셋확인하기
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Column(
                      children: [
                        TextObject("아이디", Colors.black, 20, FontWeight.bold),
                        TextObject("닉네임", Colors.black, 20, FontWeight.bold),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextObject(
                      data['loginId'], Colors.black, 20, FontWeight.w300),
                  TextObject(data['name'], Colors.black, 20, FontWeight.w300),
                ],
              ),
            ),
          ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: (() {
              openSimplePage(context, UserInfoPage());
            }),
            child: Container(
                alignment: Alignment.center,
                width: 100,
                height: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.grey[300]),
                child: TextObject("내정보", Colors.black, 15, FontWeight.w300)),
          ),
          GestureDetector(
            onTap: (() {
              _myController.onLoginDelete();
            }),
            child: Container(
                alignment: Alignment.center,
                width: 100,
                height: 35,
                decoration: BoxDecoration(
                    // boxShadow: [
                    //   BoxShadow(
                    //     spreadRadius: 1,
                    //     blurRadius: 3,
                    //     offset: Offset(0, 3),
                    //   )
                    // ],
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.grey[300]),
                child: TextObject("로그아웃", Colors.black, 15, FontWeight.w300)),
          ),
        ],
      )
    ]),
  );
  // return UserAccountsDrawerHeader(
  //   currentAccountPicture: GestureDetector(
  //     onTap: () {
  //       _myController.onLoginDelete();
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: CircleAvatar(
  //         backgroundImage:
  //             AssetImage('assets/user.png'), //이미지 삽입할때 pubspec에셋확인하기
  //         backgroundColor: Colors.white,
  //       ),
  //     ),
  //   ),
  //   accountName: Row(
  //     children: [
  //       TextObject("아이디  ", Colors.black, 20, FontWeight.bold),
  //       TextObject(data['loginId'], Colors.black, 20, FontWeight.w300),
  //     ],
  //   ),
  //   accountEmail: Row(
  //     children: [
  //       TextObject("닉네임  ", Colors.black, 20, FontWeight.bold),
  //       TextObject(data['name'], Colors.black, 20, FontWeight.w300),
  //     ],
  //   ),
  //   onDetailsPressed: () {
  //     print('arrow is clicked');
  //   },
  //   decoration: BoxDecoration(
  //       color: Colors.red[200],
  //       borderRadius: BorderRadius.only(
  //           bottomLeft: Radius.circular(40.0),
  //           bottomRight: Radius.circular(40.0))),
  // );
}

Widget notLogin(BuildContext context) {
  return Container(
      // decoration: BoxDecoration(border: Border.all()),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    TextObject("사용자 정보", Colors.black, 20, FontWeight.bold),
    Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50))),
                  child: GestureDetector(
                    child: Lottie.asset(
                      'assets/lottie/programmer.json',
                      // height: 200,
                    ), //이미지 삽입할때 pubspec에셋확인하기
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    children: [
                      TextObject("아이디", Colors.black, 20, FontWeight.bold),
                      TextObject("닉네임", Colors.black, 20, FontWeight.bold),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 100,
            child: Container(
                // alignment: Alignment.centerLeft,
                child: TextObject(
                    "사용자 정보가 없습니다.", Colors.black, 15, FontWeight.w300,
                    center: false)),
          )
        ])),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: (() {
            openSimplePage(context, SignupPage());
          }),
          child: Container(
              alignment: Alignment.center,
              width: 100,
              height: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.grey[300]),
              child: TextObject("회원가입", Colors.black, 15, FontWeight.w300)),
        ),
        GestureDetector(
          onTap: (() {
            openSimplePage(context, loginPage());
          }),
          child: Container(
              alignment: Alignment.center,
              width: 100,
              height: 35,
              decoration: BoxDecoration(
                  // boxShadow: [
                  //   BoxShadow(
                  //     spreadRadius: 1,
                  //     blurRadius: 3,
                  //     offset: Offset(0, 3),
                  //   )
                  // ],
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.grey[300]),
              child: TextObject("로그인", Colors.black, 15, FontWeight.w300)),
        ),
      ],
    )
  ]));
}
      
  // return UserAccountsDrawerHeader(
  //   currentAccountPicture: GestureDetector(
  //     onTap: () {
  //       openSimplePage(context, loginPage());
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: CircleAvatar(
  //         backgroundImage:
  //             AssetImage('assets/user.png'), //이미지 삽입할때 pubspec에셋확인하기
  //         backgroundColor: Colors.white,
  //       ),
  //       // child: Container(
  //       //   decoration:
  //       //   BoxDecoration(border: ),
  //       // ),
  //     ),
  //   ),
  //   accountName: Text("이름"),
  //   accountEmail: Text('이메일'),
  //   onDetailsPressed: () {
  //     print('arrow is clicked');
  //   },
  //   decoration: BoxDecoration(
  //       color: Colors.red[200],
  //       borderRadius: BorderRadius.only(
  //           bottomLeft: Radius.circular(40.0),
  //           bottomRight: Radius.circular(40.0))),
  // );


// class test extends UserAccountsDrawerHeader{
//   test({required super.accountName, required super.accountEmail});

// }
// class test extends State<UserAccountsDrawerHeader>{
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build

//   }

// }

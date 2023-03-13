import 'dart:ui';

import 'package:capstone1/TakePicturePage/takepic.dart';
import 'package:capstone1/community/communityPage.dart';
import 'package:capstone1/first_page/first_page.dart';
import 'package:capstone1/first_page/MainPage.dart';

import 'package:capstone1/loginPage/loginPage.dart';
import 'package:capstone1/user/UserInfo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Text TextObject(String msg, Color textColor, double fontsize, FontWeight fw,
    {bool center = true}) {
  return Text(
    msg,
    textAlign: (center == true) ? TextAlign.center : null,
    style: TextStyle(
      color: textColor,
      fontSize: fontsize,
      fontFamily: 'Tmoney',
      fontWeight: fw,
    ),
  );
}

AppBar appbarObject(String title) {
  return AppBar(
    iconTheme: IconThemeData(color: Colors.black54, size: 25),
    title: TextObject(title, Colors.black, 30, FontWeight.bold),
    toolbarHeight: 70,
    //   backgroundColor: Colors.white,
    centerTitle: true,
    elevation: 0,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
    backgroundColor: Colors.transparent,
  );
}

Widget backgroundImage(double width, double height) {
  return Container(
    width: width,
    height: height * 0.3,
    decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        image: DecorationImage(
            image: AssetImage("assets/background/camerabackground.jpg"),
            fit: BoxFit.cover)),
  );
}

Widget title(String title, double width, double height) {
  return Column(
    children: [
      Container(
        // color: Colors.blueAccent,
        margin: EdgeInsets.fromLTRB(0, height * 0.12, 0, 10),
        width: width * 0.9,
        // height: height * 0.05,
        alignment: Alignment.centerLeft,
        child: TextObject(title, Colors.black, 30, FontWeight.bold),
        // decoration:
        //     BoxDecoration(border: Border.all(color: Colors.black)),
      ),
    ],
  );
}

Drawer SideView(BuildContext context) {
  return Drawer(
    child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      UserAccountsDrawerHeader(
        currentAccountPicture: GestureDetector(
          onTap: () {
            openLoginPage(context);
          },
          child: CircleAvatar(
            backgroundImage:
                AssetImage('assets/user.png'), //이미지 삽입할때 pubspec에셋확인하기
            backgroundColor: Colors.white,
          ),
        ),
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
        title: TextObject("Take a Picture", Colors.black, 15, FontWeight.w300,
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
  );
}

Future<Null> openLoginPage(BuildContext context) {
  return Future.delayed(Duration(microseconds: 1000), () {
    showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: "login",
        transitionDuration: Duration(milliseconds: 400),
        transitionBuilder: ((_, animation, __, child) {
          Tween<Offset> tween;
          tween = Tween(begin: Offset(0, -1), end: Offset.zero);
          return SlideTransition(
            position: tween.animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
            child: child,
          );
        }),
        context: context,
        pageBuilder: ((context, _, __) => loginPage()));
  });
}

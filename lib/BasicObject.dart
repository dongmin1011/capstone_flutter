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

Future<Null> openSimplePage(BuildContext context, Widget page) {
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
        pageBuilder: ((context, _, __) => page));
  });
}

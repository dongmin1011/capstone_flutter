import 'dart:convert';

import 'package:capstone1/BasicObject.dart';
import 'package:capstone1/Token/token.dart';
import 'package:capstone1/first_page/MainPage.dart';
import 'package:capstone1/first_page/first_page.dart';
import 'package:capstone1/user/UserInfo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfoController extends GetxController {
  void onLoginUpdate(data) {
    // isLoggedIn.value = true; // 로그인 상태를 true로 변경
    // saveToken(json.encode(data));
    update();
  }
}

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  Map<String, dynamic>? data;
  // final UserInfoController _InfoController = Get.put(UserInfoController());
  @override
  void initState() {
    super.initState();
    userInfo();
    // print(data?.keys);
  }

  void userInfo() async {
    data = await getToken();
    setState(() {
      print(data?.keys);
      this.data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GetBuilder<MainPageController>(
        builder: (controller) => Center(
            child: Container(
                height: height * 0.75,
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                decoration: BoxDecoration(
                    // color: Colors.grey[200],
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    backgroundColor: Colors.transparent,
                    body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextObject("내 정보", Colors.black, 30, FontWeight.bold),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: TextObject("현재 내 정보를 확인하고 수정할 수 있어요!",
                                Colors.black, 15, FontWeight.bold,
                                center: false),
                          ),
                          Container(
                            height: height * 0.3,
                            child: FutureBuilder(
                                future: getToken(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    // print("spanpshot11111" +
                                    //     snapshot.data.toString());
                                    // setState(() {});
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextObject("아이디", Colors.black, 20,
                                                FontWeight.bold),
                                            SizedBox(
                                              width: width * 0.6,
                                              child: TextObject(
                                                  snapshot.data?['loginId'] ??
                                                      'null',
                                                  Colors.black,
                                                  20,
                                                  FontWeight.w300),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextObject("비밀번호", Colors.black, 20,
                                                FontWeight.bold),
                                            SizedBox(
                                              width: width * 0.6,
                                              child: TextObject(
                                                  snapshot.data?['password'] ??
                                                      'null',
                                                  Colors.black,
                                                  20,
                                                  FontWeight.w300),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextObject("닉네임", Colors.black, 20,
                                                FontWeight.bold),
                                            SizedBox(
                                              width: width * 0.6,
                                              child: TextObject(
                                                  snapshot.data?['name'] ??
                                                      'null',
                                                  Colors.black,
                                                  20,
                                                  FontWeight.w300),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  } else {
                                    return SizedBox();
                                  }
                                  // return SizedBox();
                                }),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    width: width * 0.3,
                                    height: height * 0.07,
                                    decoration: BoxDecoration(
                                        color: Colors.redAccent[100],
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20))),
                                    child: TextObject("확인", Colors.white, 20,
                                        FontWeight.w300)),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  data = await getToken();
                                  showGeneralDialog(
                                      barrierDismissible: true,
                                      barrierLabel: "signup",
                                      context: context,
                                      pageBuilder: ((context, _, __) =>
                                          ChangeInfoWidget(data: data)));
                                  // setState(() {});
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    width: width * 0.4,
                                    height: height * 0.07,
                                    decoration: BoxDecoration(
                                        color: Colors.redAccent[100],
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20))),
                                    child: TextObject("회원정보 수정", Colors.white,
                                        20, FontWeight.w300)),
                              ),
                            ],
                          ),
                        ])))));
  }
}

class ChangeInfoWidget extends StatelessWidget {
  ChangeInfoWidget({super.key, this.data});

  final formKey = GlobalKey<FormState>();

  var passwordField = TextEditingController(); // pw 입력 저장
  var nicknameField = TextEditingController();
  final Map<String, dynamic>? data;
  final MainPageController _myController = Get.put(MainPageController());
  final UserInfoController _InfoController = Get.put(UserInfoController());
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Center(
        child: Container(
            height: height * 0.6,
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                // color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextObject("회원정보 수정", Colors.black, 30, FontWeight.bold),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: TextObject(
                            "수정할 값을 입력해주세요!", Colors.black, 15, FontWeight.bold,
                            center: false),
                      ),
                      Form(
                        key: this.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextObject(
                              "PassWord",
                              Colors.black54,
                              20,
                              FontWeight.bold,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 5),
                              child: SizedBox(
                                height: 80,
                                child: TextFormField(
                                  // initialValue: data?['password'],

                                  controller: passwordField,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: data?['password'],
                                    // labelText: data?['password']),
                                  ),
                                  onSaved: (val) {
                                    // print(val);
                                    // user.setPassword(val!);
                                  },
                                  validator: (value) {
                                    // if (value!.isEmpty) {
                                    //   return null;
                                    // }
                                    if (value!.length != 0 &&
                                        !(value!.length > 3 &&
                                            value!.length < 9)) {
                                      return "비밀번호는 4자 이상 9자 미만으로 입력해주세요";
                                    }
                                  },
                                  // decoration: InputDecoration(

                                  //   // enabledBorder: OutlineInputBorder(
                                  //   //     borderRadius: BorderRadius.all(Radius.circular(10)))
                                  //   // prefix: Padding(padding: EdgeInsets.symmetric(horizontal: 8),)
                                  // ),
                                ),
                              ),
                            ),
                            TextObject(
                              "Name",
                              Colors.black54,
                              20,
                              FontWeight.bold,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 5),
                              child: SizedBox(
                                height: 80,
                                child: TextFormField(
                                  controller: nicknameField,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: data?['name'],
                                  ),
                                  onSaved: (val) {
                                    // print(val);
                                    // user.setNickname(val!);
                                  },
                                  validator: (value) {
                                    // if (value!.isEmpty) {
                                    //   return null;
                                    // }
                                    // return "중복된 닉네임입니다.";
                                    if (value!.length != 0 &&
                                        !(value!.length >= 2 &&
                                            value!.length < 8)) {
                                      return "닉네임은 2자 이상 8자 미만으로 입력해주세요";
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              // isLoading = true;
                              //성공
                              // formKey.currentState!.save();
                              print(1);
                              try {
                                var dio = Dio();
                                var param = {
                                  'id': data?['id'],
                                  'loginId': data?['loginId'],
                                  'password': passwordField.text == ''
                                      ? (data?['password'])
                                      : passwordField.text,
                                  'name': nicknameField.text == ''
                                      ? (data?['name'])
                                      : nicknameField.text
                                };
                                print(param);
                                var response = await dio.post(
                                    'http://118.34.54.132:8081/user/update',
                                    data: param);

                                if (response.statusCode == 200) {
                                  print(response.data);
                                  // _myController.update();
                                  updateTokenPrefix(json.encode(response.data));
                                  _myController.update();
                                  _InfoController.update();

                                  Get.back();
                                }
                              } catch (e) {
                                print(e);
                              }

                              // print(user.getId() +
                              //     user.getPassword() +
                              //     user.getNickname());
                            } else {}
                          },
                          child: Container(
                              alignment: Alignment.center,
                              width: width * 0.4,
                              height: height * 0.07,
                              decoration: BoxDecoration(
                                  color: Colors.redAccent[100],
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20))),
                              child: TextObject(
                                  "확인", Colors.white, 20, FontWeight.w300)),
                        ),
                      ),
                    ]))));
  }
}

import 'package:capstone1/BasicObject.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../user/UserInfo.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final formKey = GlobalKey<FormState>();
  // User user = new User();
  var id = TextEditingController(); // id 입력 저장
  var password = TextEditingController(); // pw 입력 저장
  var nickname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Center(
        child: Container(
            height: height * 0.75,
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                // color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: Column(children: [
                TextObject("회원가입", Colors.black, 30, FontWeight.bold),
                Stack(
                  children: [
                    Form(
                      key: this.formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextObject(
                              "ID",
                              Colors.black54,
                              20,
                              FontWeight.bold,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 5),
                              child: SizedBox(
                                // color: Colors.amber,
                                height: 80,
                                // alignment: Alignment.topCenter,

                                // padding:
                                //     const EdgeInsets.only(top: 8, bottom: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: width * 0.55,
                                      child: TextFormField(
                                        controller: id,
                                        onSaved: (val) {
                                          // user.setId(val!);
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "id는 필수입니다.";
                                          }
                                          if (!(value!.length > 3 &&
                                              value!.length < 9)) {
                                            return "id는 4자 이상 9자 미만으로 입력";
                                          }
                                        },
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: "아이디를 입력하세요",
                                          // enabledBorder: OutlineInputBorder(
                                          //     borderRadius: BorderRadius.all(Radius.circular(10)))
                                          // prefix: Padding(padding: EdgeInsets.symmetric(horizontal: 8),)
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {}, child: Text("중복확인"))
                                  ],
                                ),
                              ),
                            ),
                            TextObject(
                              "PassWord",
                              Colors.black54,
                              20,
                              FontWeight.bold,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 5),
                              child: SizedBox(
                                // alignment: Alignment.topCenter,
                                height: 80,
                                child: TextFormField(
                                  controller: password,
                                  onSaved: (val) {
                                    // print(val);
                                    // user.setPassword(val!);
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "비밀번호는 필수입니다.";
                                    }
                                    if (!(value!.length > 3 &&
                                        value!.length < 9)) {
                                      return "비밀번호는 4자 이상 9자 미만으로 입력해주세요";
                                    }
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "비밀번호를 입력하세요",
                                    // enabledBorder: OutlineInputBorder(
                                    //     borderRadius: BorderRadius.all(Radius.circular(10)))
                                    // prefix: Padding(padding: EdgeInsets.symmetric(horizontal: 8),)
                                  ),
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
                                  controller: nickname,
                                  onSaved: (val) {
                                    // print(val);
                                    // user.setNickname(val!);
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "이름은 필수입니다.";
                                    }
                                    // return "중복된 닉네임입니다.";
                                    if (!(value!.length >= 2 &&
                                        value!.length < 8)) {
                                      return "닉네임은 2자 이상 7자 미만으로 입력해주세요";
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "어플 내에서 사용할 이름을 입력하세요",
                                    // enabledBorder: OutlineInputBorder(
                                    //     borderRadius: BorderRadius.all(Radius.circular(10)))
                                    // prefix: Padding(padding: EdgeInsets.symmetric(horizontal: 8),)
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
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
                            'loginId': id.text,
                            'password': password.text,
                            'name': nickname.text
                          };
                          print(param);
                          var response = await dio.post(
                              'http://118.34.54.132:8080/signup',
                              data: param);

                          if (response.statusCode == 200) {
                            print(response.data);
                            Get.back();
                          }
                        } catch (e) {
                          print(e);
                        }

                        // print(user.getId() +
                        //     user.getPassword() +
                        //     user.getNickname());
                      } else {}
                      //
                    },
                    child: Container(
                        alignment: Alignment.center,
                        width: width * 0.6,
                        height: height * 0.07,
                        decoration: BoxDecoration(
                            color: Colors.redAccent[100],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        child: TextObject(
                            "회원가입", Colors.white, 25, FontWeight.w300)),
                  ),
                ),
              ]),
            )));
  }
}

// import 'dart:html';

import 'dart:convert';

import 'package:capstone1/BasicObject.dart';
import 'package:capstone1/TakePicturePage/takepic.dart';
import 'package:capstone1/Token/token.dart';
import 'package:capstone1/first_page/MainPage.dart';
import 'package:capstone1/loginPage/Model.dart';
import 'package:capstone1/loginPage/signUpPage.dart';
import 'package:capstone1/loginPage/social_login.dart';
import 'package:capstone1/main.dart';
import 'package:capstone1/side_menu.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:get/get.dart';

import 'package:rive/rive.dart';
import 'package:uuid/uuid.dart';

import '../first_page/first_page.dart';
import '../user/UserInfo.dart';

class loginPage extends StatefulWidget {
  loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class MyController extends GetxController {
  RxBool isActive = false.obs;
}

class _loginPageState extends State<loginPage> {
  bool isLoading = false;
  bool isShowConfetti = false;

  var loginId = TextEditingController(); // id 입력 저장
  var password = TextEditingController(); // pw 입력 저장

  late SMITrigger check;

  late SMITrigger error;

  late SMITrigger reset;
  late SMITrigger confetti;

  final formKey = GlobalKey<FormState>();
  // User user = new User();
  // late User user;

  static final storage = FlutterSecureStorage();
  // User? currentUser;
  dynamic userInfo = '';
  final viewModel = ViewModel(KakaoLogin());

  final MyController myController = Get.put(MyController());

  // _asyncMethod() async {
  //   // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
  //   // 데이터가 없을때는 null을 반환
  //   userInfo = await storage.read(key: 'jwtToken');

  //   // user의 정보가 있다면 로그인 후 들어가는 첫 페이지로 넘어가게 합니다.
  //   if (userInfo != null) {
  //     print("로그인 성공");

  //     // Get.to(takepic());
  //     // Navigator.pushNamed(context, '/main');
  //   } else {
  //     print('로그인이 필요합니다');
  //   }
  // }

  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");

    artboard.addController(controller!);
    return controller;
  }

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
            // color: Colors.grey[200],
            color: Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                TextObject("로그인", Colors.black, 30, FontWeight.bold),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextObject("로그인하여 댓글과 후기를 남겨주세요!\n", Colors.black, 15,
                      FontWeight.bold,
                      center: false),
                ),
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
                            height: 80,
                            child: TextFormField(
                              controller: loginId,
                              onSaved: (val) {
                                // user.setId(val!);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "";
                                }
                                return null;
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
                            height: 80,
                            child: TextFormField(
                              controller: password,
                              onSaved: (val) {
                                // user.setPassword(val!);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "";
                                }
                                return null;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "비밀번호를 입력하세요",
                                // enabledBorder:
                                // UnderlineInputBorder(borderSide: BorderSide.none)
                                //     OutlineInputBorder(
                                //         borderRadius: BorderRadius.all(Radius.circular(10)))
                                // )
                                // prefix: Padding(padding: EdgeInsets.symmetric(horizontal: 8),)
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                //로그인 버튼
                                onTap: () async {
                                  setState(() {
                                    isLoading = true;
                                    isShowConfetti = true;
                                  });
                                  print(loginId.text + password.text);
                                  if (formKey.currentState!.validate()) {
                                    try {
                                      var dio = Dio();
                                      var param = jsonEncode(<String, String>{
                                        'loginId': loginId.text,
                                        'password': password.text
                                      });
                                      var response = await dio.post(
                                        'http://118.34.54.132:8080/token/login',
                                        data: param,
                                        options: Options(
                                          headers: {
                                            'Content-Type':
                                                'application/json; charset=UTF-8',
                                          },
                                          responseType: ResponseType
                                              .json, // JSON 형태의 데이터를 응답으로 받음
                                        ),
                                      );

                                      if (response.statusCode == 200) {
                                        // var jwtToken = response.data['token'];
                                        // var userJson = response.data['user'];
                                        print(
                                            "data" + response.data.toString());

                                        // print(test!.values);
                                        final MainPageController _myController =
                                            Get.find<MainPageController>();

                                        // print(
                                        //     json.decode(source) + "12121212121212");
                                        // MyApp.storage.write(
                                        //     key: "token", value: response.data);
                                        // print(MyApp.storage.read(key: "token"));
                                        // print(jwtToken);
                                        // user = User.fromJson(userJson);

                                        // await storage.write(
                                        //     key: 'jwtToken', value: jwtToken);
                                        //로그인 성공시
                                        Future.delayed(Duration(seconds: 1),
                                            () {
                                          //성공
                                          check.fire(); //체크 애니케이션 출력
                                          Future.delayed(Duration(seconds: 2),
                                              () {
                                            setState(() {
                                              isLoading = false;
                                              // isShowConfetti = false;
                                            });

                                            confetti.fire();
                                            Future.delayed(Duration(seconds: 1),
                                                () {
                                              _myController.onLoginSuccess(
                                                  response.data);
                                              Get.back();

                                              // print(_myController
                                              //     .isLoggedIn.value);
                                              // MainPage.isActive.value = true;
                                              // Get.offAll(FirstPage());
                                              // _asyncMethod();
                                            });
                                          });
                                        });
                                        // print(response.data);
                                      } else {
                                        print("err");
                                        Future.delayed(Duration(seconds: 1),
                                            () {
                                          error.fire();
                                          Future.delayed(Duration(seconds: 2),
                                              () {
                                            setState(() {
                                              isLoading = false;
                                            });
                                          });
                                        });
                                      }
                                    } catch (e) {
                                      print(e);
                                      Future.delayed(Duration(seconds: 1), () {
                                        error.fire();
                                        Future.delayed(Duration(seconds: 2),
                                            () {
                                          setState(() {
                                            isLoading = false;
                                          });
                                        });
                                      });
                                    }
                                  } else {
                                    //텍스트 필드 미충족
                                    Future.delayed(Duration(seconds: 1), () {
                                      error.fire();
                                      Future.delayed(Duration(seconds: 2), () {
                                        setState(() {
                                          isLoading = false;
                                        });
                                      });
                                    });
                                  }
                                  // print("err");
                                  // Future.delayed(Duration(seconds: 1), () {
                                  //       if (formKey.currentState!.validate()) {
                                  //         //성공
                                  //         check.fire();
                                  //         Future.delayed(Duration(seconds: 2),
                                  //             () {
                                  //           setState(() {
                                  //             isLoading = false;
                                  //             // isShowConfetti = false;
                                  //           });

                                  //           confetti.fire();
                                  //           Future.delayed(Duration(seconds: 1),
                                  //               () {
                                  //             Get.back();
                                  //           });
                                  //         });
                                  //       } else {
                                  //         error.fire();
                                  //         Future.delayed(Duration(seconds: 2),
                                  //             () {
                                  //           setState(() {
                                  //             isLoading = false;
                                  //           });
                                  //         });
                                  //       }
                                  //     });
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
                                    child: TextObject("로그인", Colors.white, 20,
                                        FontWeight.w300)),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showGeneralDialog(
                                      barrierDismissible: true,
                                      barrierLabel: "signup",
                                      context: context,
                                      pageBuilder: ((context, _, __) =>
                                          SignupPage()));
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
                                    child: TextObject("회원가입", Colors.white, 20,
                                        FontWeight.w300)),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: GestureDetector(
                              onTap: () async {
                                print("카카오 로그인");
                                await viewModel.login();
                                setState(() {
                                  // Get.back();
                                  if (viewModel.isLogined) {
                                    Get.back();
                                    // Get.offAll(FirstPage());
                                    // print(viewModel.isLogined);
                                    // Future.delayed()

                                    setState(() {
                                      // Get.to(FirstPage());
                                      // Get.offAll(FirstPage());
                                      // print("끼요옹오오오오옷" +
                                      //     MyApp.storage
                                      //         .read(key: 'token')
                                      //         .toString());
                                    });
                                  }
                                });
                              },
                              child:
                                  Image.asset("assets/splash/kakao_login.png"),
                            ),
                          ),
                        ),
                      ],
                    )),
              ]),
              isLoading
                  ? CustomWidget(
                      child: RiveAnimation.asset(
                        "assets/riv/checkerror.riv",
                        onInit: (artboard) {
                          StateMachineController controller =
                              getRiveController(artboard);
                          check = controller.findSMI("Check") as SMITrigger;
                          error = controller.findSMI("Error") as SMITrigger;
                          reset = controller.findSMI("Reset") as SMITrigger;
                        },
                      ),
                    )
                  : SizedBox(),
              isShowConfetti
                  ? CustomWidget(
                      child: Transform.scale(
                      scale: 7,
                      child: RiveAnimation.asset(
                        "assets/riv/confetti.riv",
                        onInit: (artboard) {
                          StateMachineController controller =
                              getRiveController(artboard);

                          confetti = controller.findSMI("Trigger explosion")
                              as SMITrigger;
                        },
                      ),
                    ))
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

class CustomWidget extends StatelessWidget {
  const CustomWidget({super.key, required this.child, this.size = 100});

  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          Spacer(),
          SizedBox(height: size, width: size, child: child),
          Spacer(
            flex: 2,
          )
        ],
      ),
    );
  }
}

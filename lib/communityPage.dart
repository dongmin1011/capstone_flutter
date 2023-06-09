import 'dart:convert';
import 'dart:ffi';

import 'package:capstone1/BasicObject.dart';
import 'package:capstone1/StoreInfo.dart';
import 'package:capstone1/Token/token.dart';
import 'package:capstone1/first_page/MainPage.dart';
import 'package:capstone1/loginPage/loginPage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key, required this.id});
  // final Map<String, dynamic> post;
  // final Map<String, dynamic>? user;
  // final String storeName;
  final int id;

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class ChildPageController extends GetxController {
  void getReview(id) {
    getPost(id);
    update();
  }
}

class _CommunityPageState extends State<CommunityPage> {
  final _formKey = GlobalKey<FormState>();

  final ChildPageController _myController = Get.put(ChildPageController());

  TextEditingController commentController = TextEditingController();

  ScrollController _scrollController = ScrollController();
  void clearText() {
    commentController.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // 스크롤이 끝까지 도달했을 때 추가 아이템 로드
      setState(() {
        print("test");
      });
    }
  }

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    int id = widget.id;

    // Map<String, dynamic> post = widget.post;
    // List<dynamic> childList = widget.post['childDTOList'];
    String review = '';
    return GetBuilder<MainPageController>(
      builder: (controller1) => GetBuilder<ChildPageController>(
        builder: (controller) => Center(
            child: Container(
                height: height * 0.75,
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.symmetric(vertical: 32, horizontal: 20),
                decoration: BoxDecoration(
                    // color: Colors.grey[200],
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: GestureDetector(
                  onTap: () {
                    // 터치 시 포커스를 해제하여 키보드를 닫음
                    _focusNode.unfocus();
                  },
                  child: Scaffold(
                      // resizeToAvoidBottomInset: false,
                      body: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                            controller: _scrollController,
                            child: FutureBuilder(
                              future: getPost(id),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  Map<String, dynamic>? post = snapshot.data;
                                  List<dynamic> childList =
                                      post!['childDTOList'];
                                  return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextObject(
                                                (post!['title'] == "")
                                                    ? "제목없음"
                                                    : post['title'],
                                                Colors.black,
                                                20,
                                                FontWeight.bold,
                                                center: false),
                                            TextObject(
                                                post['date'],
                                                Colors.black87,
                                                10,
                                                FontWeight.w300)
                                          ],
                                        ),
                                        TextObject(
                                            "작성자: " + post['name'],
                                            Colors.black87,
                                            15,
                                            FontWeight.w300),
                                        Divider(
                                          color: Colors.black,
                                          height: 10,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: TextObject(post['review'],
                                              Colors.black, 15, FontWeight.w300,
                                              center: false),
                                        ),
                                        Divider(
                                          color: Colors.black,
                                          height: 30,
                                        ),
                                        TextObject("댓글", Colors.black87, 20,
                                            FontWeight.bold),
                                        Column(
                                          children: [
                                            ListView.builder(
                                                shrinkWrap:
                                                    true, // ListView가 자신의 크기에 맞게 축소되도록 설정
                                                physics:
                                                    NeverScrollableScrollPhysics(), // 스크롤 비활성화
                                                itemCount: childList.length > 0
                                                    ? childList.length
                                                    : 1,
                                                itemBuilder: (context, index) {
                                                  if (childList.length == 0) {
                                                    // comments가 비어 있는 경우에 대한 처리
                                                    return Container(
                                                      // width: width * 0.8,
                                                      child: TextObject(
                                                          "댓글이 존재하지 않습니다",
                                                          Colors.black54,
                                                          15,
                                                          FontWeight.w300,
                                                          center: false),
                                                    );
                                                  } else {
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              TextObject(
                                                                  (childList[
                                                                          index])[
                                                                      'name'],
                                                                  Colors.black,
                                                                  15,
                                                                  FontWeight
                                                                      .bold),
                                                              TextObject(
                                                                  (childList[
                                                                          index])[
                                                                      'date'],
                                                                  Colors.black,
                                                                  10,
                                                                  FontWeight
                                                                      .w300),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8.0,
                                                                    top: 8),
                                                            child: TextObject(
                                                                (childList[
                                                                        index])[
                                                                    'comment'],
                                                                Colors.black,
                                                                15,
                                                                FontWeight.w300,
                                                                center: false),
                                                          ),
                                                          Divider(
                                                            color: Colors.black,
                                                            height: 30,
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }
                                                }),
                                          ],
                                        ),
                                      ]);
                                } else {
                                  return Container();
                                }
                              },
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: width * 0.65,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, 2), // 그림자의 위치 조정
                                  blurRadius: 4, // 그림자의 흐림 정도 조정
                                ),
                              ],
                            ),
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                // autofocus: true,
                                focusNode: _focusNode,
                                controller: commentController,
                                decoration: InputDecoration(
                                  hintText: "댓글을 입력해주세요",
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '댓글을 입력해주세요.';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            // margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, 2), // 그림자의 위치 조정
                                  blurRadius: 4, // 그림자의 흐림 정도 조정
                                ),
                              ],
                            ),
                            child: FutureBuilder(
                              future: getToken(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return GestureDetector(
                                      onTap: () async {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState?.save();
                                          Map<String, dynamic> childData = {
                                            'id': id,
                                            'name': snapshot.data!['name'],
                                            'comment': commentController.text
                                          };

                                          print("click");
                                          String jsonString =
                                              json.encode(childData);
                                          var upload = new Dio();

                                          try {
                                            var response = await upload.post(
                                              "http://118.34.54.132:8081/database/save/community/comment",
                                              data: jsonString,
                                              options: Options(
                                                headers: {
                                                  'Content-Type':
                                                      'application/json',
                                                },
                                              ),
                                            );
                                            // print(2);
                                            if (response.statusCode == 200) {
                                              review = '';
                                              controller.getReview(id);
                                              print('성공적으로 업로드했습니다');
                                              commentController.clear();
                                              Future.delayed(
                                                  Duration(milliseconds: 500),
                                                  () {
                                                _focusNode.unfocus();
                                                _scrollController.animateTo(
                                                  _scrollController
                                                      .position.maxScrollExtent,
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeInOut,
                                                );
                                              });
                                              // Get.back();
                                            } else {
                                              print("no");
                                            }
                                          } catch (e) {
                                            print(e);
                                          }
                                        }
                                      },
                                      behavior: HitTestBehavior.opaque,
                                      child: Lottie.asset(
                                          "assets/lottie/plain3.json",
                                          width: 70));
                                } else {
                                  return GestureDetector(
                                      onTap: () {
                                        openSimplePage(context, loginPage());
                                      },
                                      behavior: HitTestBehavior.opaque,
                                      child: Lottie.asset(
                                          "assets/lottie/plain3.json",
                                          width: 70));
                                  ;
                                }
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  )),
                ))),
      ),
    );
  }
}

Future<Map<String, dynamic>?> getPost(int id) async {
  try {
    var upload = new Dio();
    //  var formData = dio.FormData.fromMap(
    //     {'storeName': test});
    Map<String, dynamic> data = {"id": id};
    String url;

    url = "http://118.34.54.132:8081/database/review/community/comments";
    // return null;

    var response = await upload.get(url, queryParameters: data
        // data: formData,
        // options: dio.Options(headers: {'Connection': 'keep-alive'}),
        );
    // print(2);
    if (response.statusCode == 200) {
      return response.data;
    }
  } catch (e) {
    print(e);
    return null;
  }
  return null;
}

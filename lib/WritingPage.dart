import 'dart:convert';

import 'package:capstone1/BasicObject.dart';
import 'package:capstone1/StoreInfo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class WritingPage extends StatefulWidget {
  const WritingPage({super.key, required this.user, required this.store});

  final Map<String, dynamic>? user;
  final String store;
  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // List<dynamic> comments = post['comments'];

    String _title = '';
    String post = '';
    return GetBuilder<StorePageController>(
      builder: (controller2) => Center(
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
                body: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextObject("게시글작성", Colors.black87, 30, FontWeight.bold),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                height: height * 0.1,
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide())),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "제목을 입력해주세요",
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '제목을 입력해주세요.';
                                    }
                                    return null;
                                  },
                                  onSaved: (val) {
                                    _title = val!;
                                  },
                                  onChanged: (value) {},
                                ),
                              ),
                            ),
                            Container(
                              height: height * 0.35,
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide())),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: '내용', hintText: "리뷰를 작성해주세요",
                                  // 밑줄 제거
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '내용을 입력해주세요.';
                                  }
                                  return null;
                                },
                                onSaved: (val) {
                                  post = val!;
                                },

                                maxLines: null, // 다중 줄 입력을 허용
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState?.save();
                                Map<String, dynamic> postData = {
                                  'storeName': widget.store,
                                  'review': {
                                    'review': post,
                                    'title': _title,
                                    'name': widget.user!['name'],
                                    'childDTOList': []
                                  }
                                };

                                print(postData);
                                String jsonString = json.encode(postData);

                                var upload = new Dio();

                                // var formData = FormData.fromMap(
                                //     );

                                try {
                                  var response = await upload.post(
                                    "http://118.34.54.132:8081/database/save/community",
                                    data: jsonString,
                                    options: Options(
                                      headers: {
                                        'Content-Type': 'application/json',
                                      },
                                    ),
                                  );
                                  // print(2);
                                  if (response.statusCode == 200) {
                                    print('성공적으로 업로드했습니다');
                                    controller2.StoreReview(
                                        widget.store, "커뮤니티");
                                    Get.back();
                                  } else {
                                    print("no");
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              }
                            },
                            child: Container(
                              width: width * 0.5,
                              height: height * 0.1,
                              decoration: BoxDecoration(
                                  color: Colors.redAccent[100],
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                      bottomLeft: Radius.circular(30))),
                              child: Center(
                                child: TextObject("게시글 등록", Colors.white, 30,
                                    FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ))),
    );
  }
}

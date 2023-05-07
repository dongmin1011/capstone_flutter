import 'dart:convert';

import 'package:capstone1/BasicObject.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart' as dio;

import 'LoadingWidget.dart';

class StoreInfo extends StatefulWidget {
  const StoreInfo({Key? key, required this.image}) : super(key: key);

  // final dynamic sendData;
  final Map<String, dynamic> image;

  @override
  State<StoreInfo> createState() => _StoreInfoState();
}

class _StoreInfoState extends State<StoreInfo> {
  // @override
  // void initState() {
  //   postUserProfileImage(formData);

  // }
  final _searchList = ['네이버', '에브리타임', '세 번째'];
  String _searchValue = "네이버";

  String comment = "네이버";

  ScrollController _scrollController = ScrollController();
  int count = 30;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // 스크롤이 끝까지 도달했을 때 추가 아이템 로드
      setState(() {
        count += 10;
        print("test");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final storeList = widget.image['names'];
    String _storeValue = storeList[0];
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // print(widget.sendData);

    // var formData = dio.FormData.fromMap({
    //                     'image': dio.MultipartFile.fromFile(widget.sendData)
    //                   });

    // Future loading() async {
    //   showDialog(
    //       context: context,
    //       builder: (context) {
    //         return Center(child: CircularProgressIndicator());
    //       });

    //   Navigator.of(context).pop();
    // }

    return Scaffold(
        extendBodyBehindAppBar: true,
        // appBar: appbarObject(""),
        body: Container(
          color: Colors.grey[200],
          child: CustomScrollView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverAppBar(
                // title: IconButton(onPressed: () {}, icon: Icon(Icons.clear)),
                toolbarHeight: 70,
                title: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
                      dropdownColor: Colors.white,
                      value: _storeValue,
                      items: storeList.map<DropdownMenuItem<String>>(
                        (value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _storeValue = value!;
                        });
                      },
                    ),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(20),
                  child: Container(
                    color: Colors.white54,
                    width: double.maxFinite,
                    child: Center(child: Text("인식된 사진")),
                    padding: EdgeInsets.only(top: 5, bottom: 10),
                    // decoration: BoxDecoration(
                    //     //     borderRadius: BorderRadius.only(
                    //     //         bottomLeft: Radius.circular(50),
                    //     // bottomRight: Radius.circular(50))
                    //     ),
                  ),
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white54,
                    child: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: (() {
                          Get.back();
                        })),
                  ),
                ),
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                pinned: true,
                backgroundColor: Colors.blueAccent,
                expandedHeight: 500,
                flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    image: DecorationImage(
                      image: MemoryImage(base64Decode(widget.image['image'])),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: Column(children: [
                    // title("Store Information", width, height),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 10),
                    //   child: Container(
                    //     child: Text("인식된 사진"),
                    //     width: width * 0.8,
                    //     height: height * 0.5,
                    //     decoration: BoxDecoration(
                    //         border: Border.all(color: Colors.black)),
                    //   ),
                    // ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        width: width * 0.95,
                        height: height * 0.7,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      TextObject("댓글 종류", Colors.black, 20,
                                          FontWeight.bold),
                                      DropdownButton(
                                        value: _searchValue,
                                        items: _searchList
                                            .map<DropdownMenuItem<String>>(
                                          (value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          },
                                        ).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            // var upload = new dio.Dio();
                                            // var Data = jsonEncode(
                                            //     <String, String>{"검색": "돼김"});
                                            // print(Data);
                                            // try {
                                            //   // dio.options.headers = {'token': token};
                                            //   var response = await upload.post(
                                            //     "http://121.185.122.19:5000/test",
                                            //     data: Data,
                                            //     options: Options(
                                            //       headers: {
                                            //         'Content-Type':
                                            //             'application/json; charset=UTF-8',
                                            //       },
                                            //       responseType: ResponseType
                                            //           .json, // JSON 형태의 데이터를 응답으로 받음
                                            //     ),
                                            //   );
                                            //   print(response);
                                            //   // print(2);
                                            //   if (response.statusCode == 200) {
                                            //     print(123);
                                            //     print(response.data);
                                            //     return response.data;
                                            //   } else {
                                            //     print("err");
                                            //   }
                                            // } catch (e) {
                                            //   print("catch err");
                                            //   print(e);
                                            // }

                                            _searchValue = value!;
                                            comment = _searchValue;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  // ElevatedButton(
                                  //     onPressed: (() {
                                  //       _scrollController.animateTo(0.0,
                                  //           duration: Duration(milliseconds: 500),
                                  //           curve: Curves.easeInOut);
                                  //     }),
                                  //     child: Text("위로"))
                                  GestureDetector(
                                    onTap: (() {
                                      _scrollController.animateTo(0.0,
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.easeInOut);
                                    }),
                                    child: CircleAvatar(
                                        backgroundColor: Colors.grey[300],
                                        child: Text("위로")),
                                  )
                                ],
                              ),
                            ),

                            // ListTile(
                            //   title: TextObject(
                            //       "Home", Colors.black, 15, FontWeight.w300,
                            //       center: false),
                            //   onTap: () {
                            //     print('home is clicked');
                            //   },
                            // ),
                            Expanded(
                              child: ListView.builder(
                                controller: _scrollController,
                                padding: EdgeInsets.only(top: 10.0),
                                // shrinkWrap: true,
                                itemCount: count,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 10),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: TextObject(
                                              "${comment}${index}",
                                              Colors.black,
                                              15,
                                              FontWeight.w300,
                                              center: false),
                                          onTap: () {
                                            print('home is clicked');
                                          },
                                        ),
                                        Divider(
                                          color: Colors.black,
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                //     // children: [
                                //     //   ListTile(
                                //     //     title: TextObject(
                                //     //         "Home", Colors.black, 15, FontWeight.w300,
                                //     //         center: false),
                                //     //     onTap: () {
                                //     //       print('home is clicked');
                                //     //     },
                                //     //   ),
                                //     // ],
                              ),
                            )
                            // ListTile(
                            //   title: TextObject(
                            //       "Home", Colors.black, 15, FontWeight.w300,
                            //       center: false),
                            //   onTap: () {
                            //     print('home is clicked');
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
              )
            ],
          ),
        ));
  }
}

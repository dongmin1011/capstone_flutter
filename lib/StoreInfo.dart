import 'dart:convert';

import 'package:capstone1/BasicObject.dart';
import 'package:capstone1/MenuPage.dart';
import 'package:capstone1/Token/token.dart';
import 'package:capstone1/WritingPage.dart';
import 'package:capstone1/communityPage.dart';
import 'package:capstone1/loginPage/loginPage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart' as dio;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'ETReviewPage.dart';
import 'LoadingWidget.dart';
import '../first_page/MainPage.dart';

class StoreInfo extends StatefulWidget {
  const StoreInfo({Key? key, required this.image}) : super(key: key);

  // final dynamic sendData;
  final Map<String, dynamic> image;

  @override
  State<StoreInfo> createState() => _StoreInfoState();
}

class StorePageController extends GetxController {
  void StoreReview(name, engine) {
    getReview(name, engine);
    update();
  }
}

class _StoreInfoState extends State<StoreInfo> {
  // @override
  // void initState() {
  //   postUserProfileImage(formData);

  // }
  final _searchList = ['네이버', '에브리타임', '커뮤니티'];
  String _searchValue = "네이버";

  String commentEngine = "네이버";

  ScrollController _scrollController = ScrollController();
  int count = 30;

  List<dynamic> storeList = [];
  String _storeValue = "test";
  Future<void> fetchStoreList() async {
    print("names" + widget.image['names'].toString());
    storeList = widget.image['names'];
    if (storeList.isNotEmpty) {
      _storeValue = storeList[0];
    }
  }

  RxBool isLoggedIn = false.obs;
  final StorePageController _myController = Get.put(StorePageController());

  // late PageController _controller;
  // dynamic currentPageValue = 0.0;
  @override
  initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    fetchStoreList();

    // _controller = PageController(initialPage: -1, viewportFraction: 0.8);
    // _controller.addListener(() {
    //   setState(() {
    //     currentPageValue = _controller.page;
    //   });
    // });
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

  bool isMenuVisible = true;
  bool isCommentsVisible = false;

  void showMenu() {
    setState(() {
      isMenuVisible = true;
      isCommentsVisible = false;
    });
  }

  void showComments() {
    setState(() {
      isMenuVisible = false;
      isCommentsVisible = true;
    });
  }

  // void storeValue(){
  //   setState(() {

  //   });
  // }
  // final storeList;
  // String _storeValue;

  @override
  Widget build(BuildContext context) {
    // final storeList = widget.image['names'];
    // String _storeValue = storeList[0];
    // final storeList = ["1", "2"];
    // String _storeValue = "1";
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GetBuilder<MainPageController>(
      builder: (controller1) => GetBuilder<StorePageController>(
        builder: (controller2) => Scaffold(
            extendBodyBehindAppBar: true,
            // appBar: appbarObject(""),
            body: Container(
              color: Colors.grey[200],
              child: CustomScrollView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
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
                          items: storeList.map(
                            (value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              print(value);
                              _storeValue = value!;
                              // print(_storeValue);
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
                          image:
                              MemoryImage(base64Decode(widget.image['image'])),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
                  ),
                  SliverToBoxAdapter(
                    child: Center(
                      child: Column(children: [
                        StoreTitle(width, height, _storeValue),
                      ]),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  Padding StoreTitle(double width, double height, String _storeValue) {
    String storeName;
    // Map<String, dynamic> storeInfoList = test(_storeValue);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        width: width * 0.95,
        height: height * 1.1,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextObject(
                        "가게 이름 ",
                        Colors.black87,
                        25,
                        FontWeight.bold,
                      ),
                      TextObject(
                        _storeValue,
                        Colors.black87,
                        20,
                        FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                FutureBuilder(
                    future: getStoreInfo(_storeValue),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print("spanpshot" + snapshot.data.toString());
                        return Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextObject(
                                "가게 정보 ",
                                Colors.black87,
                                25,
                                FontWeight.bold,
                              ),
                              SizedBox(
                                height: height * 0.2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextObject(
                                          "위치",
                                          Colors.black87,
                                          20,
                                          FontWeight.bold,
                                        ),
                                        TextObject(
                                          "전화번호",
                                          Colors.black87,
                                          20,
                                          FontWeight.bold,
                                        ),
                                        TextObject(
                                          "운영시간",
                                          Colors.black87,
                                          20,
                                          FontWeight.bold,
                                        ),
                                        TextObject(
                                          "별점",
                                          Colors.black87,
                                          20,
                                          FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextObject(
                                          snapshot.data?['address'] != null
                                              ? snapshot.data!["address"]
                                              : "",
                                          Colors.black87,
                                          15,
                                          FontWeight.bold,
                                        ),
                                        TextObject(
                                          snapshot.data?["PH"] != null
                                              ? snapshot.data!["PH"]
                                              : "",
                                          Colors.black87,
                                          15,
                                          FontWeight.bold,
                                        ),
                                        TextObject(
                                          snapshot.data?["businessTime"] != null
                                              ? snapshot.data!["businessTime"]
                                              : "",
                                          Colors.black87,
                                          15,
                                          FontWeight.bold,
                                        ),
                                        TextObject(
                                          snapshot.data!["score"] != null
                                              ? snapshot.data!["score"]
                                              : "",
                                          Colors.black87,
                                          15,
                                          FontWeight.bold,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
              ],
            ),
            menu_comment(width, height),
            // GestureDetector(
            //     onTap: () {
            //       openSimplePage(context, CommentPage());
            //     },
            //     child: Container(
            //       width: width * 0.8,
            //       height: height * 0.1,
            //       color: Colors.black,
            //     ))
          ],
        ),
      ),
    );
  }

  SingleChildScrollView menu_comment(double width, double height) {
    return SingleChildScrollView(
      // physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Column(children: [
        Container(
          height: height * 0.1,
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(),
            top: BorderSide(),
          )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                    onTap: (() {
                      print("메뉴");
                      showMenu();
                    }),
                    child: Container(
                        // decoration: BoxDecoration(
                        //   border: Border.all(),
                        // ),
                        child: TextObject(
                            "가게 메뉴", Colors.black, 20, FontWeight.bold))),
              ),
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      print("댓글");
                      showComments();
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border(left: BorderSide()),
                        ),
                        child: TextObject(
                            "댓글", Colors.black, 20, FontWeight.bold))),
              ),
            ],
          ),
        ),
        Container(
          // color: Colors.amber,
          width: width * 0.95,
          height: height * 0.60,
          child: Stack(
            children: [
              // decoration: BoxDecoration(border: Border.all()),
              if (isMenuVisible) MenuView(width, height),
              if (isCommentsVisible) CommentView(width, height),

              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    _scrollController.animateTo(0.0,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 17, 17),
                    child: Container(
                      width: 57,
                      height: 57,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          // border: Border.all(),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Lottie.asset(
                        'assets/lottie/arrow2.json',
                      ),
                    ),
                  ),
                ),
              ),
              if (_searchValue == "커뮤니티")
                Align(
                  alignment: Alignment.bottomLeft,
                  child: FutureBuilder(
                    future: getToken(),
                    builder: (context, snapshot) {
                      var isLoggedIn = snapshot.data != null;
                      print(snapshot);
                      if (isLoggedIn) {
                        return GestureDetector(
                          onTap: () {
                            print("login");
                            openSimplePage(
                                context,
                                WritingPage(
                                  user: snapshot.data,
                                  store: _storeValue,
                                ));
                          },
                          child: Lottie.asset('assets/lottie/plus.json',
                              width: 100),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () async {
                            print("notlogin");
                            await openSimplePage(context, loginPage());
                          },
                          child: Lottie.asset('assets/lottie/plus.json',
                              width: 100),
                        );
                      }
                    },
                  ),
                )
            ],
          ),
        )
      ]),
    );
  }

  Padding MenuView(double width, double height) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          FutureBuilder(
              future: getMenuInfo(_storeValue),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var menuList = snapshot.data!['menus'];
                  print(menuList);
                  return Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.only(top: 10.0),
                      // shrinkWrap: true,
                      itemCount: menuList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 0.1,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextObject((menuList[index])["foodName"],
                                          Colors.black, 20, FontWeight.bold,
                                          center: false),
                                      TextObject(
                                          (menuList[index])["price"] + "원",
                                          Colors.black,
                                          20,
                                          FontWeight.bold,
                                          center: false),
                                    ]),
                              ),
                              Divider(
                                color: Colors.black,
                                height: 5,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              })
        ],
      ),
    );
  }

  Column CommentView(double width, double height) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextObject("댓글 종류", Colors.black, 20, FontWeight.bold),
              DropdownButton(
                value: _searchValue,
                items: _searchList.map<DropdownMenuItem<String>>(
                  (value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _searchValue = value!;
                    commentEngine = _searchValue;
                    _scrollController.animateTo(0.0,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                    // print(comment);
                  });
                },
              ),
            ],
          ),
        ),

        ReviewView(commentEngine, height, width)
        // ListTile(
        //   title: TextObject(
        //       "Home", Colors.black, 15, FontWeight.w300,
        //       center: false),
        //   onTap: () {
        //     print('home is clicked');
        //   },
        // ),
      ],
    );
  }

  Widget ReviewView(String review, double height, double width) {
    return FutureBuilder(
        future: getReview(_storeValue, commentEngine),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (!snapshot.hasData) {
            // 데이터가 없는 경우 처리할 내용을 반환합니다.
            return Text('No data available');
          }
          var reviewList = snapshot.data!['reviews'];
          // print(reviewList);
          return Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.only(top: 10.0),
              // shrinkWrap: true,
              itemCount: reviewList != null ? reviewList.length : 1,
              itemBuilder: (context, index) {
                if (reviewList == null) {
                  // print("review" + reviewList.length);
                  return Container(
                    // width: width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8),
                      child: TextObject(
                          "후기가 존재하지 않습니다", Colors.black54, 15, FontWeight.w300,
                          center: false),
                    ),
                  );
                } else {
                  var imageList = (reviewList[index])['image_urls'];

                  return Padding(
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      child: Column(
                        children: [
                          if (snapshot.data!['key'] == "네이버")
                            SizedBox(
                              height: height * 0.2,
                              child: SingleChildScrollView(
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextObject(
                                              (reviewList[index])['nickName'],
                                              Colors.black,
                                              10,
                                              FontWeight.w300,
                                              center: false),
                                          TextObject(
                                              (reviewList[index])['date'],
                                              Colors.black,
                                              10,
                                              FontWeight.w300,
                                              center: false),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            child: Stack(
                                          children: [
                                            Container(
                                                width: 120,
                                                height: 120,
                                                // decoration: BoxDecoration(
                                                //     border: Border.all(),
                                                //     borderRadius:
                                                //         BorderRadius.all(
                                                //             Radius.circular(
                                                //                 30))),
                                                alignment: Alignment(0, 0.75),

                                                //dot indicator
                                                child: (imageList.length != 0)
                                                    ? PageView.builder(
                                                        itemCount:
                                                            imageList.length,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        // controller:
                                                        //     _controller,
                                                        itemBuilder:
                                                            ((context, index) {
                                                          return ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            child:
                                                                Image.network(
                                                              imageList[index],
                                                              fit: BoxFit.fill,
                                                            ),
                                                          );
                                                        }),
                                                      )
                                                    : Center(
                                                        child: TextObject(
                                                            "사진이 존재하지 않습니다.",
                                                            Colors.black54,
                                                            15,
                                                            FontWeight.w300),
                                                      )
                                                //next button
                                                )
                                          ],
                                        )),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: SizedBox(
                                            width: width * 0.5,
                                            child: TextObject(
                                                (reviewList[index])['review'],
                                                Colors.black,
                                                12,
                                                FontWeight.w300,
                                                center: false),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else if (snapshot.data!['key'] == "에브리타임")
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                openSimplePage(
                                    context,
                                    ETReviewPage(
                                      post: (reviewList[index]),
                                    ));
                              },
                              child: SizedBox(
                                width: width * 0.8,
                                height: height * 0.1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: TextObject(
                                          ((reviewList[index])['title'] == "")
                                              ? "제목없음"
                                              : (reviewList[index])['title'],
                                          Colors.black,
                                          15,
                                          FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 8),
                                      child: Text(
                                        (((reviewList[index])['review'] == null)
                                            ? ""
                                            : (reviewList[index])['review']),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: 'Tmoney',
                                          fontWeight: FontWeight.w300,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else if (snapshot.data!['key'] == "커뮤니티")
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                print(snapshot.data);

                                openSimplePage(
                                    context,
                                    CommunityPage(
                                      id: ((reviewList[index])['id']),
                                      // user: login.data,
                                    ));
                              },
                              child: SizedBox(
                                width: width * 0.8,
                                height: height * 0.1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextObject(
                                            ((reviewList[index])['title'] == "")
                                                ? "제목없음"
                                                : (reviewList[index])['title'],
                                            Colors.black,
                                            15,
                                            FontWeight.bold),
                                        TextObject((reviewList[index])['date'],
                                            Colors.black, 10, FontWeight.w300,
                                            center: false),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 8),
                                      child: Text(
                                        (((reviewList[index])['review'] == null)
                                            ? ""
                                            : (reviewList[index])['review']),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: 'Tmoney',
                                          fontWeight: FontWeight.w300,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          Divider(
                            color: Colors.black,
                            height: 10,
                          ),
                        ],
                      ));
                }
              },
            ),
          );
        });
  }
}

Future<Map<String, dynamic>?> getStoreInfo(String test) async {
  try {
    var upload = new Dio();
    //  var formData = dio.FormData.fromMap(
    //     {'storeName': test});
    Map<String, dynamic> data = {"Name": test};

    var response = await upload.get(
        "http://118.34.54.132:8081/database/getStore",
        queryParameters: data
        // data: formData,
        // options: dio.Options(headers: {'Connection': 'keep-alive'}),
        );
    // print(2);
    if (response.statusCode == 200) {
      print(response.data);
      return response.data;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<Map<String, dynamic>?> getMenuInfo(String name) async {
  try {
    var upload = new Dio();
    //  var formData = dio.FormData.fromMap(
    //     {'storeName': test});
    Map<String, dynamic> data = {"Name": name};

    var response = await upload
        .get("http://118.34.54.132:8081/database/getMenu", queryParameters: data
            // data: formData,
            // options: dio.Options(headers: {'Connection': 'keep-alive'}),
            );
    // print(2);
    if (response.statusCode == 200) {
      print(response.data);
      return response.data;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<Map<String, dynamic>?> getReview(String name, String engine) async {
  try {
    var upload = new Dio();
    //  var formData = dio.FormData.fromMap(
    //     {'storeName': test});
    Map<String, dynamic> data = {"Name": name};
    String url;
    if (engine == "네이버") {
      url = "http://118.34.54.132:8081/database/review/naver";
    } else if (engine == "에브리타임") {
      url = "http://118.34.54.132:8081/database/review/everytime";
    } else {
      url = "http://118.34.54.132:8081/database/review/community";
      // return null;
    }

    var response = await upload.get(url, queryParameters: data
        // data: formData,
        // options: dio.Options(headers: {'Connection': 'keep-alive'}),
        );
    // print(2);
    if (response.statusCode == 200) {
      print(response.data);
      if (engine == "네이버")
        response.data['key'] = "네이버";
      else if (engine == "에브리타임")
        response.data['key'] = "에브리타임";
      else if (engine == "커뮤니티") response.data['key'] = "커뮤니티";
      return response.data;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

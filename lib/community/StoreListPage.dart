import 'dart:convert';

import 'package:capstone1/BasicObject.dart';
import 'package:capstone1/StoreInfo.dart';
import 'package:capstone1/Token/token.dart';
import 'package:capstone1/first_page/MainPage.dart';
import 'package:capstone1/ip.dart';
import 'package:capstone1/loginPage/loginPage.dart';
import 'package:capstone1/sideview/sideview.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';

import 'package:image/image.dart' as img;

import 'StoreListToInfo.dart';

class StoreListPage extends StatefulWidget {
  const StoreListPage({super.key});

  // final List<dynamic>? response;

  @override
  State<StoreListPage> createState() => _CommunityPageState();
}

// class ListPageController extends GetxController {}
class ListPageController extends GetxController {}

class _CommunityPageState extends State<StoreListPage> {
  ScrollController _scrollController = ScrollController();
  List<String> _searchList = ['좋아요 개수', '조회 수', '가나다 순'];
  String _searchValue = "좋아요 개수";

  final ListPageController _myController = Get.put(ListPageController());

  // @override
  // void initState() {
  //   // TODO: implement initState

  //   // for (var item in widget.response) {
  //   //   storeNames.add(item);
  //   // }
  //   storeNames = widget.response!
  //       .map((storeData) => storeData['storeName'] as String)
  //       .toList();
  // }
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    // var storeNames = widget.response;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GetBuilder<MainPageController>(
        builder: (controller) => GetBuilder<ListPageController>(
            builder: (controller2) => Scaffold(
                // backgroundColor: Colors.grey[200],
                extendBodyBehindAppBar: true,
                // backgroundColor: Color(0xff235883),
                appBar: appbarObject(""),
                drawer: const SideView(),
                body: Container(
                    color: Colors.grey[200],
                    child: Stack(children: [
                      backgroundImage(
                          width, height, "assets/background/community.jpg"),
                      Center(
                          child: Column(children: [
                        title("Community Page", width, height),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            width: width * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.white38,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, top: 5, bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextObject("정렬 방법", Colors.black, 20,
                                      FontWeight.bold),
                                  Expanded(flex: 1, child: SizedBox()),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white54,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: DropdownButton(
                                      value: _searchValue,
                                      items: _searchList
                                          .map<DropdownMenuItem<String>>(
                                        (String item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: TextObject(
                                                item,
                                                Colors.black,
                                                13,
                                                FontWeight.bold),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          _searchValue = value!;
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(flex: 1, child: SizedBox()),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Hero(
                            tag: 'community',
                            child: FutureBuilder(
                                future: getToken(),
                                builder: (context, snapshot) {
                                  var isLoggedIn = snapshot.data != null;
                                  return SizedBox(
                                    width: width * 0.9,
                                    height: height * 0.7,
                                    child: FutureBuilder(
                                      // future: Future.delayed(
                                      //     Duration(seconds: 1),
                                      //     () => orderby(_searchValue)),
                                      future: orderby(_searchValue),
                                      builder: (context, snapshot1) {
                                        print(snapshot1);
                                        if (snapshot1.connectionState ==
                                            ConnectionState.waiting) {
                                          // isLoading = true;
                                          return Center(
                                              child: SpinKitFadingCircle(
                                            color: Colors.red,
                                          ));
                                        } else {
                                          // isLoading = false;
                                          return Column(

                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                              // mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                    child: Stack(children: [
                                                  Container(
                                                      //가게 정보 리스트 출력
                                                      // color: Colors.white,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5),
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 3,
                                                            blurRadius: 10,
                                                            offset: Offset(0,
                                                                10), // changes position of shadow
                                                          ),
                                                        ],
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(30),
                                                          // bottomLeft: Radius.circular(30)
                                                        ),
                                                        // border: Border.all()
                                                      ),
                                                      child: GridView.builder(
                                                          controller:
                                                              _scrollController,
                                                          padding: EdgeInsets
                                                              .only(top: 10.0),
                                                          gridDelegate:
                                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                                  crossAxisCount:
                                                                      2,
                                                                  childAspectRatio:
                                                                      1 / 1.3,
                                                                  mainAxisSpacing:
                                                                      20,
                                                                  crossAxisSpacing:
                                                                      20),
                                                          itemCount: snapshot1
                                                                      .data !=
                                                                  null
                                                              ? snapshot1
                                                                  .data!.length
                                                              : 1,
                                                          itemBuilder:
                                                              ((context,
                                                                  index) {
                                                            var alreadySaved = snapshot
                                                                    .data?[
                                                                        'storeDTOList']
                                                                    ?.contains((snapshot1
                                                                            .data![index])[
                                                                        'storeName']) ??
                                                                false;

                                                            // var alreadySaved = snapshot
                                                            //     .data!['storeDTOList']
                                                            //     .contains((storeNames[
                                                            //             index])[
                                                            //         'storeName']);
                                                            var photoUrl =
                                                                (snapshot1.data![
                                                                        index])[
                                                                    'storePhoto'];
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      15.0),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: //현재 사진으로 가게 정보 페이지를 open
                                                                    () async {
                                                                  // 네트워크이미지를 가져오는 방법
                                                                  controller2
                                                                      .update();
                                                                  Get.to(
                                                                      StoreListInfo(
                                                                          image: {
                                                                            'names':
                                                                                [
                                                                              (snapshot1.data![index])['storeName']
                                                                            ],
                                                                            'image':
                                                                                photoUrl
                                                                          }),
                                                                      transition:
                                                                          Transition
                                                                              .upToDown);
                                                                },
                                                                child: Container(
                                                                    width: width,
                                                                    height: height,
                                                                    decoration: BoxDecoration(boxShadow: [
                                                                      BoxShadow(
                                                                        color: Colors
                                                                            .grey
                                                                            .withOpacity(0.5),
                                                                        spreadRadius:
                                                                            3,
                                                                        blurRadius:
                                                                            10,
                                                                        offset: Offset(
                                                                            0,
                                                                            10), // changes position of shadow
                                                                      ),
                                                                    ], color: Colors.white, borderRadius: const BorderRadius.only(topRight: Radius.circular(30), bottomLeft: Radius.circular(30)), border: Border.all()),
                                                                    // child: Text(
                                                                    //     index
                                                                    //         .toString()),
                                                                    child: Stack(
                                                                      children: [
                                                                        //여기에 이미지 삽입
                                                                        ClipRRect(
                                                                          borderRadius: const BorderRadius
                                                                              .only(
                                                                              bottomLeft: Radius.circular(30),
                                                                              topRight: Radius.circular(30)),
                                                                          child:
                                                                              Container(
                                                                            decoration: BoxDecoration(
                                                                                image: DecorationImage(
                                                                                    image: NetworkImage(photoUrl),
                                                                                    colorFilter: ColorFilter.mode(
                                                                                      Colors.black.withOpacity(0.6), // 투명도 조절
                                                                                      BlendMode.dstATop, // 블렌드 모드 설정
                                                                                    ),
                                                                                    fit: BoxFit.cover)),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              bottom: 35),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                Alignment.bottomLeft,
                                                                            child:
                                                                                Container(
                                                                              width: width,
                                                                              color: Colors.white70,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 8.0, top: 2, bottom: 2),
                                                                                child: TextObject(snapshot1.data?[index]['storeName'] ?? 'No Name', Colors.black, 13, FontWeight.bold, center: false),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              bottom: 10.0,
                                                                              right: 10),
                                                                          child: Align(
                                                                              alignment: Alignment.bottomRight,
                                                                              // child: isLoggedIn
                                                                              //     ? IconButton(
                                                                              //         icon: alreadySaved ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                                                                              //         color: alreadySaved ? Colors.red : null,
                                                                              //         onPressed: () async {
                                                                              //           var upload = Dio();

                                                                              //           try {
                                                                              //             var response = await upload.post(
                                                                              //               "http://$ip:8081/user/${alreadySaved ? 'delete' : 'favorite'}Store",
                                                                              //               data: {
                                                                              //                 'id': snapshot.data!['id'],
                                                                              //                 'name': (storeNames[index])['storeName']
                                                                              //               },
                                                                              //             );

                                                                              //             if (response.statusCode == 200) {
                                                                              //               controller2.update();
                                                                              //             }
                                                                              //           } catch (e) {
                                                                              //             print(e);
                                                                              //           }
                                                                              //         })
                                                                              //     : IconButton(
                                                                              //         onPressed: () {
                                                                              //           openSimplePage(context, loginPage());
                                                                              //         },
                                                                              //         icon: Icon(Icons.favorite_border))
                                                                              child: isLoggedIn
                                                                                  ? GestureDetector(
                                                                                      onTap: () async {
                                                                                        var upload = Dio();

                                                                                        try {
                                                                                          var response = await upload.post(
                                                                                            "http://$ip/user/${alreadySaved ? 'delete' : 'favorite'}Store",
                                                                                            data: {
                                                                                              'id': snapshot.data!['id'],
                                                                                              'name': (snapshot1.data![index])['storeName']
                                                                                            },
                                                                                          );

                                                                                          if (response.statusCode == 200) {
                                                                                            controller2.update();
                                                                                          }
                                                                                        } catch (e) {
                                                                                          print(e);
                                                                                        }
                                                                                      },
                                                                                      child: Container(
                                                                                        child: alreadySaved ? const Icon(Icons.favorite, color: Colors.red) : const Icon(Icons.favorite_border),
                                                                                        // color: alreadySaved ? Colors.red : null,
                                                                                      ))
                                                                                  : GestureDetector(
                                                                                      onTap: () {
                                                                                        openSimplePage(context, loginPage());
                                                                                      },
                                                                                      child: const Icon(Icons.favorite_border))),
                                                                        )
                                                                      ],
                                                                    )),
                                                              ),
                                                            );
                                                          }))),
                                                  Padding(
                                                    //화면을 위로 올리는 버튼
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: GestureDetector(
                                                        onTap: (() {
                                                          _scrollController.animateTo(
                                                              0.0,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      500),
                                                              curve: Curves
                                                                  .easeInOut);
                                                        }),
                                                        child: SizedBox(
                                                          width: 70,
                                                          height: 70,
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors.yellow[
                                                                    300],
                                                            child: Lottie.asset(
                                                              'assets/lottie/arrow2.json',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ]))
                                              ]);
                                        }
                                      },
                                    ),
                                  );
                                }))
                      ])),
                      // isLoading
                      //     ? Stack(
                      //         children: [
                      //           Opacity(
                      //             opacity: 0.3,
                      //             child: ModalBarrier(
                      //                 dismissible: false,
                      //                 color: Colors.black54),
                      //           ),
                      //           Center(
                      //             child: SpinKitFadingCircle(color: Colors.red),
                      //           ),
                      //         ],
                      //       )
                      //     : SizedBox()
                    ])))));
  }
}

Future<List<dynamic>?> orderby(String search) async {
  var dio = new Dio();

  String orderby = "";
  switch (search) {
    case "좋아요 개수":
      orderby = 'favorite';
      break;
    case "가다나 순":
      orderby = 'name';
      break;
    case "조회 수":
      orderby = 'views';
      break;
  }
  try {
    var response = await dio
        .get('http://$ip/get/storeList', queryParameters: {'orderBy': orderby});

    return response.data;
  } catch (e) {
    print(e);
  }
  return null;
}

Future<List<dynamic>?> test() async {
  var dio = new Dio();

  try {
    var response = await dio.get('http://$ip/get/storeList');

    return response.data;
  } catch (e) {
    print(e);
  }
  return null;
}

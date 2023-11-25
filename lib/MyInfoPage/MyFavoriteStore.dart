import 'package:capstone1/BasicObject.dart';
import 'package:capstone1/Token/token.dart';
import 'package:capstone1/community/StoreListPage.dart';
import 'package:capstone1/community/StoreListToInfo.dart';
import 'package:capstone1/ip.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class MyFavoriteStore extends StatefulWidget {
  const MyFavoriteStore({super.key});

  @override
  State<MyFavoriteStore> createState() => _MyFavoriteStoreState();
}

class UserFavoriteController extends GetxController {}

class _MyFavoriteStoreState extends State<MyFavoriteStore> {
  final UserFavoriteController _InfoController =
      Get.put(UserFavoriteController());
  final ListPageController _myController = Get.put(ListPageController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GetBuilder<UserFavoriteController>(
        builder: (controller) => GetBuilder<ListPageController>(
            builder: (controller2) => Center(
                child: Container(
                    height: height * 0.7,
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
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: TextObject("좋아요 목록", Colors.black, 30,
                                    FontWeight.bold),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: TextObject("내가 좋아요를 누른 가게를 볼 수 있어요!",
                                    Colors.black, 15, FontWeight.bold,
                                    center: false),
                              ),
                              FutureBuilder(
                                  future: getToken(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      // isLoading = true;
                                      return Center(
                                          child: SpinKitFadingCircle(
                                        color: Colors.red,
                                      ));
                                    }
                                    return SizedBox(
                                        width: width * 0.9,
                                        height: height * 0.47,
                                        child: snapshot.data!['storeDTOList']
                                                    .length !=
                                                0
                                            ? Column(

                                                // crossAxisAlignment: CrossAxisAlignment.start,
                                                // mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                    Expanded(
                                                        child: Stack(children: [
                                                      Container(
                                                          //가게 정보 리스트 출력
                                                          // color: Colors.white,
                                                          padding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          5),
                                                          // decoration: BoxDecoration(
                                                          // border: Border.all()),
                                                          child:
                                                              GridView.builder(
                                                                  // controller:
                                                                  //     _scrollController,
                                                                  padding: EdgeInsets.only(
                                                                      top:
                                                                          10.0),
                                                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                                      crossAxisCount:
                                                                          2,
                                                                      childAspectRatio:
                                                                          1 /
                                                                              1.3,
                                                                      mainAxisSpacing:
                                                                          20,
                                                                      crossAxisSpacing:
                                                                          20),
                                                                  itemCount: (snapshot.data?['storeDTOList']?.length ??
                                                                              0) !=
                                                                          0
                                                                      ? snapshot
                                                                          .data![
                                                                              'storeDTOList']
                                                                          .length
                                                                      : 1,
                                                                  itemBuilder:
                                                                      ((context,
                                                                          index) {
                                                                    // var alreadySaved = snapshot
                                                                    //         .data?[
                                                                    //             'storeDTOList']
                                                                    //         ?.contains((snapshot1
                                                                    //                     .data![
                                                                    //                 index])[
                                                                    //             'storeName']) ??
                                                                    //     false;

                                                                    // if (!alreadySaved) {
                                                                    //   return SizedBox
                                                                    //       .shrink();
                                                                    // }

                                                                    // var alreadySaved = snapshot
                                                                    //     .data!['storeDTOList']
                                                                    //     .contains((storeNames[
                                                                    //             index])[
                                                                    //         'storeName']);

                                                                    print("11" +
                                                                        snapshot
                                                                            .data
                                                                            .toString());

                                                                    return FutureBuilder(
                                                                      future: getStoreInfo(
                                                                          snapshot.data!['storeDTOList']
                                                                              [
                                                                              index]),
                                                                      builder:
                                                                          (context,
                                                                              snapshot1) {
                                                                        // if (snapshot1.connectionState ==
                                                                        //     ConnectionState.waiting) {
                                                                        //   // isLoading = true;
                                                                        //   return Center(
                                                                        //       child: SpinKitFadingCircle(
                                                                        //     color:
                                                                        //         Colors.red,
                                                                        //   ));
                                                                        // }
                                                                        return Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(15.0),
                                                                            child: GestureDetector(
                                                                              onTap: //현재 사진으로 가게 정보 페이지를 open
                                                                                  () async {
                                                                                // 네트워크이미지를 가져오는 방법
                                                                                // controller2
                                                                                // .update();
                                                                                // Get.to(
                                                                                //     StoreListInfo(
                                                                                //         image: {
                                                                                //           'names': [
                                                                                //             (snapshot1
                                                                                //                 .data![index])['storeName']
                                                                                //           ],
                                                                                //           'image':
                                                                                //               'https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20191016_66%2F1571209505378LeouK_JPEG%2FnG2qPNC0oc6RPNo4l8aV_4FE.jpg'
                                                                                //         }),
                                                                                //     transition:
                                                                                //         Transition
                                                                                //             .upToDown);
                                                                              },
                                                                              child: Container(
                                                                                  width: width,
                                                                                  height: height,
                                                                                  decoration: BoxDecoration(boxShadow: [
                                                                                    BoxShadow(
                                                                                      color: Colors.grey.withOpacity(0.5),
                                                                                      spreadRadius: 3,
                                                                                      blurRadius: 10,
                                                                                      offset: Offset(0, 10), // changes position of shadow
                                                                                    ),
                                                                                  ], color: Colors.white, borderRadius: const BorderRadius.only(topRight: Radius.circular(30), bottomLeft: Radius.circular(30)), border: Border.all()),
                                                                                  // child: Text(
                                                                                  //     index
                                                                                  //         .toString()),
                                                                                  child: Stack(
                                                                                    children: [
                                                                                      //여기에 이미지 삽입
                                                                                      snapshot1 != null
                                                                                          ? ClipRRect(
                                                                                              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), topRight: Radius.circular(30)),
                                                                                              child: Container(
                                                                                                decoration: BoxDecoration(
                                                                                                    image: DecorationImage(
                                                                                                        image: NetworkImage(snapshot1.data?['storePhoto'] ?? 'https://images.chosun.com/resizer/Ai5P44iGt4TR6ZOTlD2kKuR0Lpc=/616x0/filters:focal(1671x1128:1681x1138)/cloudfront-ap-northeast-1.images.arcpublishing.com/chosun/2KW67JZBLZAEXJKCXJOV6VUCZM.jpg'),
                                                                                                        colorFilter: ColorFilter.mode(
                                                                                                          Colors.black.withOpacity(0.6), // 투명도 조절
                                                                                                          BlendMode.dstATop, // 블렌드 모드 설정
                                                                                                        ),
                                                                                                        fit: BoxFit.cover)),
                                                                                              ),
                                                                                            )
                                                                                          : Container(),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(bottom: 35),
                                                                                        child: Align(
                                                                                          alignment: Alignment.bottomLeft,
                                                                                          child: Container(
                                                                                            width: width,
                                                                                            color: Colors.white70,
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.only(left: 8.0, top: 2, bottom: 2),
                                                                                              child: TextObject(snapshot.data!['storeDTOList'][index], Colors.black, 13, FontWeight.bold, center: false),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                          padding: const EdgeInsets.only(bottom: 10.0, right: 10),
                                                                                          child: Align(
                                                                                              alignment: Alignment.bottomRight,
                                                                                              child: GestureDetector(
                                                                                                  onTap: () async {
                                                                                                    var upload = Dio();

                                                                                                    try {
                                                                                                      // var response = await upload.post(
                                                                                                      //   "http://$ip:8081/user/${alreadySaved ? 'delete' : 'favorite'}Store",
                                                                                                      //   data: {
                                                                                                      //     'id': snapshot.data!['id'],
                                                                                                      //     'name': (snapshot1.data![index])['storeName']
                                                                                                      //   },
                                                                                                      // );

                                                                                                      // if (response.statusCode == 200) {
                                                                                                      //   controller2.update();
                                                                                                      // }
                                                                                                    } catch (e) {
                                                                                                      print(e);
                                                                                                    }
                                                                                                  },
                                                                                                  child: Container(child: const Icon(Icons.favorite, color: Colors.red)
                                                                                                      // color: alreadySaved ? Colors.red : null,
                                                                                                      ))))
                                                                                    ],
                                                                                  )),
                                                                            ));
                                                                      },
                                                                    );
                                                                  })))
                                                    ]))
                                                  ])
                                            : Center(
                                                child: TextObject(
                                                    "좋아요 목록이 없습니다.",
                                                    Colors.black,
                                                    20,
                                                    FontWeight.w300),
                                              ));
                                  })
                            ]))))));
  }
}

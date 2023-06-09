import 'package:capstone1/BasicObject.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class ETReviewPage extends StatelessWidget {
  const ETReviewPage({super.key, required this.post});
  final Map<String, dynamic> post;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<dynamic> comments = post['comments'];
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
                body: SingleChildScrollView(
                    // physics: BouncingScrollPhysics(
                    //     parent: AlwaysScrollableScrollPhysics()),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                  TextObject((post['title'] == "") ? "제목없음" : post['title'],
                      Colors.black, 20, FontWeight.bold,
                      center: false),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextObject(
                        post['review'], Colors.black, 15, FontWeight.w300,
                        center: false),
                  ),
                  Divider(
                    color: Colors.black,
                    height: 50,
                  ),
                  TextObject("댓글", Colors.black87, 20, FontWeight.bold),
                  Column(
                      // height: 300,
                      children: [
                        ListView.builder(
                          shrinkWrap: true, // ListView가 자신의 크기에 맞게 축소되도록 설정
                          physics: NeverScrollableScrollPhysics(), // 스크롤 비활성화
                          itemCount: comments.length > 0 ? comments.length : 1,
                          itemBuilder: (context, index) {
                            if (comments.length == 0) {
                              // comments가 비어 있는 경우에 대한 처리
                              return Container(
                                // width: width * 0.8,
                                child: TextObject("댓글이 존재하지 않습니다",
                                    Colors.black54, 15, FontWeight.w300,
                                    center: false),
                              );
                            } else {
                              // comments가 비어 있지 않은 경우에 대한 처리
                              // return Container();
                              Map<String, dynamic> comment = comments[index];
                              return Column(
                                children: [
                                  Container(
                                      // height: height * 0.1,
                                      width: width * 0.8,
                                      // decoration:
                                      //     BoxDecoration(border: Border.all()),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: TextObject(
                                                comment['date'],
                                                Colors.black87,
                                                10,
                                                FontWeight.w300),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: TextObject(
                                                comment['text'],
                                                Colors.black,
                                                15,
                                                FontWeight.w300,
                                                center: false),
                                          ),
                                          if (comment['child'] != null)
                                            ListView.builder(
                                              shrinkWrap:
                                                  true, // ListView가 자신의 크기에 맞게 축소되도록 설정
                                              physics:
                                                  NeverScrollableScrollPhysics(), // 스크롤 비활성화
                                              itemCount:
                                                  comment["child"].length,
                                              itemBuilder: (context, index) {
                                                Map<String, dynamic> child =
                                                    (comment['child'])[index];
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '➥', // ➥ 이모티콘
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Container(
                                                          width: width * 0.7,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.grey[
                                                                      300],
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10))),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child: TextObject(
                                                                        child[
                                                                            'date'],
                                                                        Colors
                                                                            .black87,
                                                                        10,
                                                                        FontWeight
                                                                            .w300),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            10.0),
                                                                    child: TextObject(
                                                                        child[
                                                                            'text'],
                                                                        Colors
                                                                            .black87,
                                                                        15,
                                                                        FontWeight
                                                                            .w300,
                                                                        center:
                                                                            false),
                                                                  ),
                                                                ]),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            )
                                        ],
                                      )),
                                  Divider(
                                    color: Colors.black,
                                    height: 30,
                                  ),
                                ],
                              );
                              // return ListTile(
                              //   title: Text(comment["text"]),
                              //   subtitle: Text(comment["date"]),
                              //   // 자식 댓글이 있는 경우 처리
                              //   trailing: comment["child"].isNotEmpty
                              //       ? ListView.builder(
                              //           shrinkWrap: true,
                              //           itemCount: comment["child"].length,
                              //           itemBuilder: (context, childIndex) {
                              //             Map<String, dynamic>
                              //                 childComment =
                              //                 comment["child"][childIndex];
                              //             return ListTile(
                              //               title:
                              //                   Text(childComment["text"]),
                              //               subtitle:
                              //                   Text(childComment["date"]),
                              //             );
                              //           },
                              //         )
                              //       : null,
                              // );
                            }
                          },
                        ),
                      ])
                ])))));
  }
}

import 'package:capstone1/BasicObject.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
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
          body: SingleChildScrollView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(),
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
                                      child: TextObject("가게 메뉴", Colors.black,
                                          20, FontWeight.bold))),
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
                                      child: TextObject("댓글", Colors.black, 20,
                                          FontWeight.bold))),
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
                            if (isMenuVisible)
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Column(
                                  children: [
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceEvenly,
                                    //   children: [
                                    //     TextObject("메뉴", Colors.black87, 20,
                                    //         FontWeight.bold),
                                    //     TextObject("가격", Colors.black87, 20,
                                    //         FontWeight.bold),
                                    //   ],
                                    // ),
                                    Expanded(
                                        child: GridView.builder(
                                      controller: _scrollController,
                                      padding: EdgeInsets.only(top: 10.0),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, // 열의 수
                                        crossAxisSpacing: 10, // 아이템 간의 가로 간격
                                        mainAxisSpacing: 20, // 아이템 간의 세로 간격
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(30),
                                                  topRight: Radius.circular(30),
                                                  bottomLeft:
                                                      Radius.circular(30))),
                                          height: 100,
                                          width: 100,
                                          child: Center(child: Text("사진")),
                                        );
                                      },
                                      itemCount: 10, // 아이템 개수
                                    )),
                                  ],
                                ),
                              ),
                            if (isCommentsVisible) CommentView(),

                            Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: () {
                                  _scrollController.animateTo(0.0,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      // border: Border.all(),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  child: RotatedBox(
                                      quarterTurns: 2,
                                      child: Lottie.asset(
                                          'assets/lottie/arrow.json')),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ]))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column CommentView() {
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
                    comment = _searchValue;
                    _scrollController.animateTo(0.0,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                    print(comment);
                  });
                },
              ),

              // GestureDetector(
              //   onTap: (() {
              //     _scrollController.animateTo(0.0,
              //         duration: Duration(milliseconds: 500),
              //         curve: Curves.easeInOut);
              //   }),
              //   child: CircleAvatar(
              //       backgroundColor: Colors.grey[300],
              //       child: Text("위로")),
              // )
            ],
          ),
        ),

        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.only(top: 10.0),
            // shrinkWrap: true,
            itemCount: count,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Column(
                  children: [
                    ListTile(
                      title: TextObject("${comment}${index}", Colors.black, 15,
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
    );
  }
}

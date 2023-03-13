import 'package:capstone1/BasicObject.dart';
import 'package:dio/src/response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key, required this.response});

  final String response;

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  ScrollController _scrollController = ScrollController();
  final _searchList = ['좋아요 순', '많이 찾은 순', '세 번째'];
  String _searchValue = "좋아요 순";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        extendBodyBehindAppBar: true,
        // backgroundColor: Color(0xff235883),
        appBar: appbarObject(""),
        drawer: SideView(context),
        body: Center(
          child: Column(
            children: [
              title("Community Page", width, height),
              Container(
                  width: width * 0.9,
                  height: height * 0.8,
                  // decoration:
                  //     BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                TextObject(
                                    "정렬 방법", Colors.black, 20, FontWeight.bold),
                                DropdownButton(
                                  value: _searchValue,
                                  items:
                                      _searchList.map<DropdownMenuItem<String>>(
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
                                    });
                                  },
                                ),
                              ],
                            ),
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
                      Expanded(
                        child: Container(
                          // decoration: BoxDecoration(border: Border.all()),
                          child: GridView.builder(
                            controller: _scrollController,
                            padding: EdgeInsets.only(top: 10.0),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1 / 1.5,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 10),
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        border: Border.all())),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }
}

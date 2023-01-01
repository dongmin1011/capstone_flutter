import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:capstone1/main.dart';

class takepic extends StatefulWidget {
  static const routeName = '/getimage';

  @override
  State<takepic> createState() => _GetImageState();
}

class _GetImageState extends State<takepic> {
  // const GetImage({super.key});

  File? _image;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('사진 입력'),
        centerTitle: true,
        elevation: 5.0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
                //  color: Colors.black,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                // padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                width: width * 0.9,
                height: height * 0.6,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    // boxShadow: [
                    //   BoxShadow(
                    //     //     color: Color.fromARGB(255, 224, 78, 127),
                    //     blurRadius: 10,
                    //     spreadRadius: 2,
                    //   )
                    // ],
                    border: Border.all(color: Colors.black38, width: 3)),
                child: SizedBox(
                    width: width * 0.9,
                    height: height * 0.6,
                    child: TextButton(
                        child: showImage(),
                        onPressed: () {
                          getImage(ImageSource.camera);
                        },
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)))))),
            //     OutlinedButton(
            //   child: showImage(),
            //   onPressed: () {
            //     getImage(ImageSource.camera);
            //   },
            //   style: OutlinedButton.styleFrom(
            //       alignment: Alignment.center,

            //     //  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            //      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            //       minimumSize: Size(width * 0.9, height * 0.6),
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(50.0))),

            // ),
            SizedBox(height: 10),
            ButtonBar(alignment: MainAxisAlignment.center,
                //   buttonPadding: EdgeInsets.all(20),
                children: [
                  ElevatedButton(
                      onPressed: () {
                        getImage(ImageSource.camera);
                      },
                      child: Text('Camera')),
                  SizedBox(
                    width: 50.0,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        getImage(ImageSource.gallery);
                      },
                      child: Text('Gallery')),
                ]),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              child: Text('가게 판독하기'),
              onPressed: () {
                Fluttertoast.showToast(
                    msg: '사진 전송',
                    gravity: ToastGravity.CENTER,
                    toastLength: Toast.LENGTH_SHORT);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget showImage() {
    if (_image == null) {
      return Text(
        "사진을 입력해주세요",
        style: TextStyle(
            fontSize: 30, fontFamily: 'TMoney', fontWeight: FontWeight.bold),
      );
    } else {
      return ClipRRect(
          borderRadius: BorderRadius.circular(50), child: Image.file(_image!));
    }
  }

  Future getImage(ImageSource imageSource) async {
    var image = await ImagePicker.platform.pickImage(source: imageSource);

    setState(() {
      _image = File(image!.path);
    });
  }
}

import 'dart:async';
import 'dart:convert';
// import 'dart:html';

import 'package:camera/camera.dart';
import 'package:capstone1/TakePicturePage/ImageWidget.dart';
import 'package:capstone1/StoreInfo.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:capstone1/main.dart';
import 'package:location/location.dart';
import 'package:capstone1/BasicObject.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import '../LoadingWidget.dart';
// import 'package:flutter/animation.dart';

class takepic extends StatefulWidget {
  static const routeName = '/getimage';

  @override
  State<takepic> createState() => _GetImageState();
}

class _GetImageState extends State<takepic>
    with SingleTickerProviderStateMixin {
  // with SingleTickerProviderStateMixin
  // const GetImage({super.key});
  // late final AnimationController _controller;
  // late final AnimationController _controller;
  // @override
  // void initState() {
  //   super.initState();

  //   _controller = AnimationController(
  //       vsync: this, duration: const Duration(microseconds: 700));
  // }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }
  // @override
  // void initState() {
  //   // final spinkit = SpinKitSquareCircle(
  //   //   color: Colors.black,
  //   //   size: 50.0,
  //   //   controller: AnimationController(
  //   //       vsync: this, duration: const Duration(milliseconds: 1200)),
  //   // );
  //   _controller = AnimationController(
  //       vsync: this, duration: const Duration(milliseconds: 1200));
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   // TODO: implement dispose
  //   _controller.dispose();
  // }

  File? _image;
  // String path = 'http://211.105.163.155:8080/basic/form';
  // AnimationController controller = AnimationController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // print(width.toString() + "," + height.toString());
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey[200],
      appBar: appbarObject(""),
      drawer: SideView(context),
      body: Container(
        child: Stack(children: [
          // backgroundImage(width, height),

          Center(
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  title("FIND STORE", width, height),
                  Hero(
                    tag: "tagHero",
                    child: GestureDetector(
                      onTap: () => _SelectPhotoOption(context),
                      child: Container(
                          //   child: showImage(),
                          alignment: Alignment.center,
                          // margin: EdgeInsets.symmetric(
                          //     horizontal: 10, vertical: 20),
                          //    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          width: width * 0.9,
                          height: height * 0.65,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(55)),
                              // boxShadow: [
                              //   BoxShadow(
                              //     //     color: Color.fromARGB(255, 224, 78, 127),
                              //     blurRadius: 10,
                              //     spreadRadius: 2,
                              //   )
                              // ],
                              border:
                                  Border.all(color: Colors.black38, width: 3)),
                          //   child: showImage(),
                          child: _image == null
                              ? TextObject("사진을 입력해주세요", Colors.black, 30,
                                  FontWeight.bold)
                              : Container(
                                  // child: Center(
                                  //     child: const SpinKitRotatingCircle(
                                  //   color: Colors.black,

                                  //   // controller: AnimationController(vsync: this),
                                  // )),
                                  child: Stack(
                                    children: [
                                      SpinKitFoldingCube(
                                        duration: Duration(seconds: 1),
                                        itemBuilder: (_, int index) {
                                          return DecoratedBox(
                                              decoration: BoxDecoration(
                                            color: index.isEven
                                                ? Colors.red
                                                : Colors.green,
                                          ));
                                        },
                                      ),
                                      Container(
                                          decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        image: DecorationImage(
                                            image: Image.file(_image!).image,
                                            fit: BoxFit.cover),
                                      )),
                                    ],
                                  ),
                                )),
                    ),
                  ),
                  // child: SizedBox(
                  //     width: width * 0.9,
                  //     height: height * 0.7,
                  //     child: TextButton(
                  //         child: showImage(),
                  //         onPressed: () {
                  //           //  getImage(ImageSource.camera);
                  //           _SelectPhotoOption(context);
                  //         },
                  //         style: TextButton.styleFrom(
                  //             shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(50.0)))))),
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
                  //   SizedBox(height: 10),
                  // ButtonBar(alignment: MainAxisAlignment.center,
                  //     //   buttonPadding: EdgeInsets.all(20),
                  //     children: [
                  //       ElevatedButton(
                  //           onPressed: () {
                  //             getImage(ImageSource.camera);
                  //           },
                  //           child: Text('Camera')),
                  //       SizedBox(
                  //         width: 50.0,
                  //       ),
                  //       ElevatedButton(
                  //           onPressed: () {
                  //             getImage(ImageSource.gallery);
                  //           },
                  //           child: Text('Gallery')),
                  //     ]),

                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_image == null) {
                        Fluttertoast.showToast(
                            msg: '사진이 입력되지 않았습니다.',
                            toastLength: Toast.LENGTH_SHORT);
                        null;
                      } else {
                        getCurrentLocation();
                        // Future<LocationData> curlacation;
                        // Location location = new Location();
                        // curlacation = location.getLocation();
                        // print("Pressedlocation= " + curlacation.toString());
                        Fluttertoast.showToast(
                            msg: '사진 전송', //$curlacation',
                            // gravity: ToastGravity.CENTER,
                            toastLength: Toast.LENGTH_SHORT);

                        // List<int> imageBytes = _image!.readAsBytesSync();
                        // String base64Image = base64Encode(imageBytes);
                        // print("Json" + base64Image);

                        // Uri url = Uri.parse('http://221.144.8.121:8080/basic/test');

                        // http.Response response = await http.post(
                        //   url,
                        //   headers: <String, String>{
                        //     "Content-Type": "application/json; charset=UTF-8",
                        //   }, // this header is essential to send json data
                        //   body: jsonEncode({"image": "$base64Image"}),
                        // );
                        // print("Json" + response.body);
                        //    postHTTP();
                        // dynamic sendData;
                        if (_image != null) {
                          // postUserProfileImage(_image!.path);
                          Get.to(() => StoreInfo(response: "hi"),
                              transition: Transition.upToDown);
                        }
                        // var formData = dio.FormData.fromMap({
                        //   'image': await dio.MultipartFile.fromFile(sendData)
                        // });

                        // print(formData.files);
                        // postUserProfileImage(formData);

                      }
                      // Center(child: CircularProgressIndicator());
                      // IsLoadingController.to.isLoading = true; // 돌돌이 소환!
                    },
                    child: Container(
                        width: width * 0.8,
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            color: Colors.black),
                        child: Container(
                          child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Lottie.asset('assets/lottie/rocket.json'),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    //  alignment: Alignment.centerRight,

                                    //    color: Colors.blue,
                                    child: TextObject("사진 판독하기", Colors.white,
                                        30, FontWeight.bold)),
                              ]),
                        )),
                  ),
                ]),
          ),

          // Obx(() => Offstage(
          //     offstage:
          //         !IsLoadingController.to.isLoading, // isLoading이 false면 감춰~
          //     child: Stack(children: const <Widget>[
          //       //다시 stack
          //       Opacity(
          //         //화면을 뿌옇게 설정

          //         opacity: 0.5, //0.5만큼~
          //         child: ModalBarrier(
          //             dismissible: false, color: Colors.black), //클릭 못하게~
          //       ),
          //       Center(
          //         child: CircularProgressIndicator(),
          //       )
          //     ])))
          Obx(
            //isLoading(obs)가 변경되면 다시 그림.
            () => Offstage(
              offstage:
                  !IsLoadingController.to.isLoading, // isLoading이 false면 감춰~
              child: Stack(children: <Widget>[
                //다시 stack
                Opacity(
                  //뿌옇게~
                  opacity: 0.3,
                  child: ModalBarrier(
                      dismissible: false, color: Colors.black), //클릭 못하게~
                ),
                Center(
                  child: SpinKitFadingCircle(
                    color: Colors.red,
                    // itemBuilder: (_, int ndex){
                    // return DecoratedBox(
                    //     decoration: BoxDecoration(
                    //   color: index.isEven ? Colors.red : Colors.green,
                    // );
                    // },
                  ),
                  //     child: Lottie.asset(
                  //   "assets/lottie/loading_camera.json",
                  //   // controller: _controller,
                  //   // onLoaded: (comp)=>{
                  //   //   _controller.duration = comp.duration
                  //   // }
                  // )
                  // Lottie.asset("assets/lottie/loading_camera.json");
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  // Future<void> postHTTP() async {
  //   List<int> imageBytes = _image!.readAsBytesSync();
  //   String base64Image = base64Encode(imageBytes);
  //   print("Json" + base64Image);

  //   Uri url = Uri.parse('http://211.105.163.155:8080/basic/test');

  //   http.Response response = await http.post(
  //     url,
  //     headers: <String, String>{
  //       "Content-Type": "application/json; charset=UTF-8",
  //     }, // this header is essential to send json data
  //     body: jsonEncode({"image": "$base64Image"}),
  //   );
  //   if (response.statusCode == 200) {
  //     print("success");
  //     print("Json" + response.body);
  //   } else {
  //     print("err");
  //   }
  // }

  Future<dynamic> postUserProfileImage(dynamic input) async {
    print("사진을 서버에 업로드 합니다.");
    var upload = new dio.Dio();
    var formData = dio.FormData.fromMap(
        {'image': await dio.MultipartFile.fromFile(input)});
    IsLoadingController.to.isLoading = true;
    try {
      upload.options.contentType = 'multipart/form-data';
      upload.options.maxRedirects.isFinite;
      // print(1);

      // dio.options.headers = {'token': token};
      var response = await upload.post(
        "http://118.34.54.132:8080/upload/picture",
        data: formData,
      );
      // print(2);
      if (response.statusCode == 200) {
        print('성공적으로 업로드했습니다');
        IsLoadingController.to.isLoading = false;
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => StoreInfo(response: response.data)));
        Get.to(() => StoreInfo(response: response.data),
            transition: Transition.upToDown);
        print(response.data);
        return response.data;
      } else {
        print("err");
      }
    } catch (e) {
      print("catch err");
      print(e);
    }
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
    // var image = await ImagePicker.platform.pickImage(source: imageSource);
    // // image = image == null?Text('No image'):Image.file(File(image.path));
    // setState(() {
    //   _image = File(image!.path);
    // });
    try {
      final cameras = await availableCameras();
      print(cameras);
      final firstCamera = cameras[0];
      final image = await ImagePicker().pickImage(
        source: imageSource,
        preferredCameraDevice: CameraDevice.rear,
      ); //후면카메라 실행

      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this._image = imageTemporary;
        // Navigator.of(context).pop();

        Get.back();
      });
    } on PlatformException catch (e) {
      // Navigator.of(context).pop();
      Get.back();
    }
  }

  void _SelectPhotoOption(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(50.0),
        )),
        builder: (context) => DraggableScrollableSheet(
            initialChildSize: 0.28,
            maxChildSize: 0.3,
            minChildSize: 0.1,
            expand: false,
            builder: ((context, scrollController) {
              return SingleChildScrollView(
                  controller: scrollController,
                  child: SelectPhoto(
                    onTap: getImage,
                  ));
            })));
  }
}

Future<void> getCurrentLocation() async {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  _locationData = await location.getLocation();
}

// Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => StoreInfo(
//       response: 'hi',
//     ),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(0.0, 1.0);
//       const end = Offset.zero;
//       const curve = Curves.ease;

//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }

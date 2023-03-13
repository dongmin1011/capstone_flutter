import 'package:capstone1/BasicObject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class SelectPhoto extends StatelessWidget {
  final Function(ImageSource source) onTap;
  const SelectPhoto({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(20),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            //   top: -35,
            child: Container(
              width: 50,
              height: 6,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.5),
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextObject("사진을 입력할 수단", Colors.black, 20, FontWeight.bold),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () => onTap(ImageSource.camera),
                    child: Container(
                        child: SelectButton(width * 0.6,
                            'assets/lottie/camera-icon-lottie.json', "카메라")),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () => onTap(ImageSource.gallery),
                    child: Container(
                        child: SelectButton(width * 0.6,
                            'assets/lottie/picturelottie.json', "갤러리")),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

Container SelectButton(double width, String lottie, String Text) {
  return Container(
      width: width,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: Colors.white,
        border: Border.all(color: Colors.black38, width: 3),
        boxShadow: [
          BoxShadow(
              color: Colors.black54,
              //   blurRadius: 100.0,
              blurRadius: 5.0,
              offset: Offset(0, 5))
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            lottie,
            // width: 30,
            // height: 300,
          ),
          SizedBox(
            width: 20,
          ),
          TextObject(Text, Colors.black, 30, FontWeight.bold),
        ],
      ));
}

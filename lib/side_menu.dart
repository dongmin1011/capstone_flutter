import 'package:capstone1/BasicObject.dart';
import 'package:capstone1/TakePicturePage/takepic.dart';
import 'package:capstone1/first_page/first_page.dart';
import 'package:capstone1/rivAsset/RiveAsset.dart';
import 'package:capstone1/rivAsset/RiveUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:rive/rive.dart';

class SideMenuPage extends StatefulWidget {
  const SideMenuPage({super.key});

  @override
  State<SideMenuPage> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenuPage> {
  RiveAsset selectedMenu = sideMenus.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          // width: 288,
          height: double.infinity,
          color: Color(0xff235883),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserInfo(
                  name: "dongmin",
                  profession: "kim",
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                  child: Text(
                    "메뉴 목록",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white60),
                  ),
                ),
                // SideMenu()
                ...sideMenus.map(((menu) => SideMenu(
                      menu: menu,
                      riveonInit: (artboard) {
                        //클릭시 애니메이션
                        StateMachineController controller =
                            RiveUtils.getRiveController(artboard,
                                stateMachineName: menu.stateName);
                        menu.input = controller.findSMI("active") as SMIBool;
                      },
                      press: () {
                        menu.input!.change(true);
                        Future.delayed(const Duration(milliseconds: 500), () {
                          menu.input!.change(false);
                        });
                        setState(() {
                          selectedMenu = menu;
                        });
                        // Get.toNamed("/first");
                        // Get.to((FirstPage()) => takepic());
                        // if (menu.title == "Home")
                        //   Get.offAll(FirstPage());
                        // else if (menu.title == "Take a Picture")
                        // Get.back();
                        // Get.to(() => takepic());
                      },
                      isActive: selectedMenu == menu,
                    ))),
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                  child: Text(
                    "History".toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white60),
                  ),
                ),
                // ...sideMenus2.map(((menu) => SideMenu(
                //       menu: menu,
                //       riveonInit: (artboard) {
                //         //클릭시 애니메이션
                //         StateMachineController controller =
                //             RiveUtils.getRiveController(artboard,
                //                 stateMachineName: menu.stateName);
                //         menu.input = controller.findSMI("active") as SMIBool;
                //       },
                //       press: () {
                //         menu.input!.change(true);
                //         Future.delayed(const Duration(seconds: 1), () {
                //           menu.input!.change(false);
                //         });
                //         setState(() {
                //           selectedMenu = menu;
                //         });
                //       },
                //       isActive: selectedMenu == menu,
                //     )))
              ],
            ),
          )),
    );
  }
}

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
    required this.menu,
    required this.press,
    required this.riveonInit,
    required this.isActive,
  }) : super(key: key);

  final RiveAsset menu;
  final VoidCallback press;
  final ValueChanged<Artboard> riveonInit;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Divider(
            color: Colors.white30,
            height: 1,
          ),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              curve: Curves.fastOutSlowIn,
              duration: Duration(milliseconds: 300),
              height: 56,
              width: isActive ? 288 : 0,
              left: 0,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            ListTile(
              onTap: press,
              leading: SizedBox(
                height: 34,
                width: 34,
                child: RiveAnimation.asset(
                  menu.src,
                  artboard: menu.artboard,
                  onInit: riveonInit,
                ),
              ),
              title: Text(
                menu.title,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key? key,
    required this.name,
    required this.profession,
  }) : super(key: key);
  final String name, profession;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      width: 287,
      height: 200,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
              width: 250,
              child: TextObject("사용자 정보", Colors.black, 25, FontWeight.bold,
                  center: false)),
          ListTile(
            leading: CircleAvatar(
              // radius: 50,
              backgroundColor: Colors.white24,
              child: Icon(
                CupertinoIcons.person,
                color: Colors.white,
              ),
            ),
            title: TextObject(name, Colors.black, 20, FontWeight.bold,
                center: false),
            subtitle: Text(profession),
          ),
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(45),
              bottomRight: Radius.circular(45)),
          color: Colors.red[200]),
    );
  }
}

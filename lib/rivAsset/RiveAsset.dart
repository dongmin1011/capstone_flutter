import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveAsset {
  final String artboard, stateName, title, src;
  late SMIBool? input;

  RiveAsset(this.src,
      {required this.artboard,
      required this.stateName,
      required this.title,
      this.input});
}

List<RiveAsset> sideMenus = [
  RiveAsset("assets/riv/icon_set.riv",
      artboard: "HOME", stateName: "HOME_interactivity", title: "Home"),
  RiveAsset("assets/riv/icon_set.riv",
      artboard: "SEARCH",
      stateName: "SEARCH_Interactivity",
      title: "Take a Picture"),
  RiveAsset("assets/riv/icon_set.riv",
      artboard: "HOME", stateName: "HOME_interactivity", title: "Home")
];
// List<RiveAsset> sideMenus2 = [
//   RiveAsset("assets/riv/icon_set.riv",
//       artboard: "TIMER", stateName: "TIMER_interactivity", title: "History"),
// ];

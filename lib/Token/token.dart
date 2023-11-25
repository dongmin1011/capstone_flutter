import 'dart:convert';

import 'package:capstone1/ip.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// 토큰 저장
Future<void> saveToken(String token) async {
  final storage = FlutterSecureStorage();
  print("save token");
  await storage.write(key: 'token', value: token);
}

// 토큰 가져오기
Future<Map<String, dynamic>?> getToken() async {
  final storage = FlutterSecureStorage();
  // json.dc
  // json.decode(storage.read(key: 'token'));
  String jsonString = await storage.read(key: 'token') ?? '';
  if (jsonString == '') {
    return null;
  }
  // print(jsonString);
  // return null;
  Map<String, dynamic> jsonData = jsonDecode(jsonString);
  // print('ggg' + jsonData.toString());
  var dio = new Dio();
  var response = await dio.get("http://$ip/user/get/favoriteStore",
      queryParameters: {'id': jsonData['id']});
  if (response.statusCode == 200) {
    jsonData['storeDTOList'] = response.data;
  }
  return jsonData;
}

// 정보 업데이트
Future<Map<String, dynamic>?> updateToken(int id) async {
  final storage = FlutterSecureStorage();
  // json.dc
  // json.decode(storage.read(key: 'token'));
  String jsonString = await storage.read(key: 'token') ?? '';
  if (jsonString == '') {
    return null;
  }
  // print(id);
  var dio = new Dio();
  var response = await dio
      .get("http://$ip/user/get/favoriteStore", queryParameters: {'id': id});
  if (response.statusCode == 200) {
    print('kkk' + response.data.toString());
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    jsonData['storeDTOList'] = response.data;
    return jsonData;
  }
}

// 토큰 수정
Future<void> updateTokenPrefix(String newPrefix) async {
  final storage = FlutterSecureStorage();
  Map<String, dynamic>? tokenData = await getToken();
  if (tokenData != null) {
    await storage.write(key: 'token', value: newPrefix);
  }
}

// Future<void> updateStore(int id) async {
//   // final storage = FlutterSecureStorage();
//   final storage = FlutterSecureStorage();
//   String jsonString = await storage.read(key: 'token') ?? '';
//   if (jsonString == '') {
//     return null;
//   }
//   var dio = new Dio();
//   var response = await dio.get("http://$ip:8081/user/get/favoriteStore",
//       queryParameters: {'id': id});
//   if (response.statusCode == 200) {
//     print('kkk' + response.data.toString());
//   }
//   // await storage.write(key: 'storeDTOList', value: response.data);
//   // Map<String, dynamic> jsonData = jsonDecode(jsonString);
//   // jsonData['sotreDTOList'].add(data);
// }
Future<List<String>?> getStoreDTOList(int id) async {
  final storage = FlutterSecureStorage();
  Map<String, dynamic>? tokenData = await getToken();
  if (tokenData != null) {
    // await storage.write(key: 'token', value: newPrefix);
    var dio = new Dio();
    var response = await dio
        .get("http://$ip/user/get/favoriteStore", queryParameters: {'id': id});
    if (response.statusCode == 200) {
      print(response.data);
    }
  }
  return null;

  // final storage = FlutterSecureStorage();
  // String jsonString = await storage.read(key: 'token') ?? '';
  // if (jsonString == '') {
  //   return null;
  // }
  // Map<String, dynamic> jsonData = jsonDecode(jsonString);
  // if (jsonData.containsKey('storeDTOList')) {
  //   List<dynamic> storeList = jsonData['storeDTOList'];
  //   if (storeList is List) {
  //     return storeList.map((item) => item.toString()).toList();
  //   }
  // }
  // return null;
}

// 토큰 삭제
Future<void> deleteToken() async {
  final storage = FlutterSecureStorage();
  print("delete");
  await storage.delete(key: 'token');
}

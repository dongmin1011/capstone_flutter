import 'dart:convert';

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
  // return null;
  Map<String, dynamic> jsonData = jsonDecode(jsonString);
  print(jsonData);
  return jsonData;
}

// 토큰 수정
Future<void> updateTokenPrefix(String newPrefix) async {
  final storage = FlutterSecureStorage();
  Map<String, dynamic>? tokenData = await getToken();
  if (tokenData != null) {
    await storage.write(key: 'token', value: newPrefix);
  }
}

// 토큰 삭제
Future<void> deleteToken() async {
  final storage = FlutterSecureStorage();
  print("delete");
  await storage.delete(key: 'token');
}

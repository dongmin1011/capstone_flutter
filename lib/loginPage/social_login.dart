import 'dart:convert';

import 'package:capstone1/main.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

abstract class SocialLogin {
  Future<bool> login();

  Future<bool> logout();
}

class KakaoLogin implements SocialLogin {
  final String key = 'token';
  @override
  Future<bool> login() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      // print(isInstalled);
      if (isInstalled) {
        try {
          await UserApi.instance.loginWithKakaoTalk();
          return true;
        } catch (e) {
          return false;
        }
      } else {
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          // String tokenString = json.encode(token.toJson());

          // await MyApp.storage.write(key: key, value: tokenString);
          // print(token);
          return true;
        } catch (e) {
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await UserApi.instance.unlink();
      return true;
    } catch (error) {
      return false;
    }
  }
}

import 'package:capstone1/loginPage/social_login.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class ViewModel {
  final SocialLogin _socialLogin;
  bool isLogined = false;
  User? user;

  ViewModel(this._socialLogin);

  Future login() async {
    isLogined = await _socialLogin.login();
    print(isLogined);
    if (isLogined) {
      user = await UserApi.instance.me();
    }
  }

  Future logout() async {
    await _socialLogin.logout();
    isLogined = false;
    user = null;
  }
}

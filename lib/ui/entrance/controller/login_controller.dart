import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_get/http/model/base_response.dart';
import 'package:test_get/http/repository/user_repository.dart';
import 'package:test_get/model/user_entity.dart';
import 'package:test_get/ui/navigator/navigator_page.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  var user = UserEntity().obs;

  String account = '1@1.com';
  String password = 'a1234567';

  String? checkAccount(String? account) {
    if (account == null) {
      return 'please enter account';
    }
    //邮箱正则
    RegExp mailVerify =
        RegExp(r'[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$');
    return mailVerify.hasMatch(account) ? null : 'Incorrect account format';
  }

  String? checkPassword(String? password) {
    if (password == null) {
      return 'please enter password';
    }
    //密码正则
    RegExp passwordVerify =
        RegExp(r"(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$");
    return passwordVerify.hasMatch(password)
        ? null
        : 'Incorrect password format';
  }

  login() async {
    //作弊流程
    if (account == '1@1.com') {
      debugPrint('作弊登录通过');
      Get.off(const NavigatorPage());
      return;
    }

    //正常流程
    ApiResponse response = await UserRepository.signIn(account, password);
    if (response.status == Status.completed) {
      //处理请求成功,Rx会自动更新user
      user(response.data);
    } else {
      //处理异常
      debugPrint(response.exception.toString());
    }
  }

  @override
  onInit() {
    debugPrint('初始化你想要的数据，例如列表第一页，用户信息，商品信息等。。。');
    super.onInit();
  }

  @override
  onClose() {
    debugPrint('释放资源，例如重置表单等。。。');
    super.onClose();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_get/http/api_exceptions.dart';
import 'package:test_get/http/model/base_response.dart';
import 'package:test_get/http/repository/user_repository.dart';
import 'package:test_get/model/user_entity.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  var user = UserEntity().obs;
  var isLogin = false.obs;

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

  Future<ApiException?> login() async {
    //作弊流程
    if (account == '1@1.com' && password == 'a1234567') {
      UserEntity userEntity = UserEntity();
      userEntity.account = '1@1.com';
      userEntity.nickname = '有点上火';
      userEntity.avatar =
          'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fedpic%2F09%2F44%2F5d%2F09445d7fe08dc405a67b8bff169f9825.jpg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1670226224&t=4dc5d184bdd3dd43f09eb13cdc46de71';
      userEntity.age = 28;
      userEntity.gender = 0;
      user(userEntity);
      isLogin(true);
      debugPrint('作弊登录通过');
      return null;
    }

    //正常流程
    ApiResponse response = await UserRepository.signIn(account, password);
    if (response.status == Status.completed) {
      //处理请求成功,Rx会自动更新user
      user(response.data);
    } else {
      //处理异常
      return response.exception;
    }
    return null;
  }

  logout() {
    isLogin(false);
  }

  @override
  onInit() {
    debugPrint('初始化数据，例如列表第一页，用户信息，商品信息等');
    super.onInit();
  }

  @override
  onClose() {
    debugPrint('释放资源，例如重置表单等');
    super.onClose();
  }
}

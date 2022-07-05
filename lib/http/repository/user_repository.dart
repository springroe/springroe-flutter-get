import 'package:dio/dio.dart';
import 'package:test_get/http/api.dart';
import 'package:test_get/http/dio_client.dart';
import 'package:test_get/http/model/base_response.dart';
import 'package:test_get/model/user_entity.dart';
import 'package:test_get/utils/cipher.dart';

class UserRepository {
  /// 登录
  /// account : 用户名
  /// password : 密码
  static Future<ApiResponse<UserEntity>> signIn(
      String account, String password) async {
    try {
      // 请求接口
      Map<String, dynamic> data = await DioClient.instance.post(Api.signIn,
          options: Options(contentType: contentTypeUrlencoded),
          data: {
            'username': account,
            'password': generateMD5(password),
          });
      // 返回实体
      return ApiResponse.completed(UserEntity.fromJson(data));
    } on DioError catch (e) {
      // 捕捉异常
      return ApiResponse.error(e.error);
    }
  }
}

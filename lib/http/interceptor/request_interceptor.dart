import 'package:dio/dio.dart';

import '../api_exceptions.dart';

/// 请求处理拦截器
class RequestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 此处添加header信息
    // options.headers = {
    //   'Authorization': 'bearer ${token.accessToken}',
    // };
    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    // token过期处理，获取新的token以后再执行请求
    // if (err.response?.statusCode == 424) {
    //   //找到登录账号密码
    //   String? accountStr = SpUtil().getJSON(spKeyUser);
    //   if (accountStr != null && accountStr.isNotEmpty) {
    //     AccountEntity account = AccountEntity.fromJson(jsonDecode(accountStr));
    //     //获取新的token
    //     ApiResponse<String?> response =
    //         await UserRepository.signIn(account.account, account.password);
    //     if (response.status == Status.completed) {
    //       //重新执行token失效前的请求
    //       RequestOptions? request = err.response?.requestOptions;
    //       Response response = await DioClient.instance.dio.request(
    //           request!.path,
    //           data: request.data,
    //           options: Options(
    //               method: request.method,
    //               headers: request.headers,
    //               contentType: request.contentType),
    //           queryParameters: request.queryParameters,
    //           cancelToken: request.cancelToken,
    //           onReceiveProgress: request.onReceiveProgress);
    //       handler.resolve(response);
    //     }
    //   }
    // } else {
    //   ApiException appException =
    //       ApiException.create(err, err.response?.data['msg']);
    //   err.error = appException;
    // }
    ApiException appException =
        ApiException.create(err, err.response?.statusMessage);
    err.error = appException;
    return super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 此处处理返回的异常
    if (response.statusCode != 200) {
      // 请求错误跳到异常处理
      handler.reject(
          DioError(
              requestOptions: response.requestOptions,
              response: response,
              type: DioErrorType.response),
          true);
    } else {
      handler.next(response);
    }
  }
}

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import 'interceptor/request_interceptor.dart';

const contentTypeUrlencoded = 'application/x-www-form-urlencoded';

class DioClient {
  static const String url = 'http://fuckyou.com';

  ///超时时间 10秒
  static const int connectTimeout = 10000;
  static const int receiveTimeout = 10000;

  static DioClient instance = DioClient._internal();

  factory DioClient() => instance;

  Dio dio = Dio();

  final CancelToken _cancelToken = CancelToken();

  DioClient._internal() {
    dio.options
      ..baseUrl = url
      ..connectTimeout = connectTimeout
      ..receiveTimeout = receiveTimeout
      ..validateStatus = (int? status) {
        return status != null && status > 0;
      };
    dio.interceptors.add(RequestInterceptor());
    dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true)); //打开日志
  }

  /// 设置headers
  void setHeaders(Map<String, dynamic> map) {
    dio.options.headers.addAll(map);
  }

/*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests({CancelToken? token}) {
    token ?? _cancelToken.cancel("cancelled");
  }

  /// restful get 操作
  Future get(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    bool refresh = false,
    bool noCache = true,
    String? cacheKey,
    bool cacheDisk = false,
  }) async {
    Options requestOptions =
        options ?? Options(contentType: contentTypeUrlencoded);
    requestOptions = requestOptions.copyWith(extra: {
      "refresh": refresh,
      "noCache": noCache,
      "cacheKey": cacheKey,
      "cacheDisk": cacheDisk,
    });
    Response response;
    response = await dio.get(path,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  /// restful post 操作
  Future post(
    String path, {
    Map<String, dynamic>? params,
    data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    var response = await dio.post(path,
        data: data,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  /// restful put 操作
  Future put(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();

    var response = await dio.put(path,
        data: data,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  /// restful patch 操作
  Future patch(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    var response = await dio.patch(path,
        data: data,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  /// restful delete 操作
  Future delete(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    var response = await dio.delete(path,
        data: data,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  /// restful post form 表单提交操作
  Future postForm(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    var data = FormData.fromMap(params!);
    var response = await dio.post(path,
        data: data,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  ///文件下载
  ///url 下载的地址
  ///progressCallback 下载进度变化时的回调，用来实现进度条
  Future<Response> dioDownload(
    String url,
    progressCallback, {
    CancelToken? cancelToken,
  }) async {
    Directory tempDir = await getTemporaryDirectory();
    Directory directory = Directory('${tempDir.path}/local_video/');

    String file = '${directory.path}/$url'; //本地文件名
    Response response = await Dio().download(url, file,
        onReceiveProgress: (int count, int total) {
      if (total == -1) {
        //不知道进度的默认50%
        total = count * 2;
      }
      progressCallback(count, total);
    }, cancelToken: cancelToken ?? _cancelToken);
    response.extra = <String, dynamic>{"localPath": file};
    return response;
  }
}

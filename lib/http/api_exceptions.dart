import 'package:dio/dio.dart';
import 'package:test_get/generated/l10n.dart';

/// 自定义异常
class ApiException implements Exception {
  final int? _code;

  final String? _message;

  ApiException([this._code, this._message]);

  @override
  String toString() {
    return "ErrorCode:($_code) \n$_message";
  }

  factory ApiException.create(DioError error, String? message) {
    switch (error.type) {
      case DioErrorType.cancel:
        return BadRequestException(error.type.index, S.current.netWorkCancel);
      case DioErrorType.connectTimeout:
        return BadRequestException(
            error.type.index, S.current.netWorkConnectionTimeOut);
      case DioErrorType.sendTimeout:
        return BadRequestException(
            error.type.index, S.current.netWorkSendTimeOut);
      case DioErrorType.receiveTimeout:
        return BadRequestException(
            error.type.index, S.current.netWorkReceiveTimeout);
      case DioErrorType.response:
        {
          try {
            int errCode = error.response?.statusCode ?? 0;
            switch (errCode) {
              case 400:
                {
                  return BadRequestException(
                      errCode, S.current.netWorkGrammaticalError);
                }
              case 401:
                {
                  return UnauthorisedException(
                      errCode, S.current.netWorkPermissionDenied);
                }
              case 403:
                {
                  return UnauthorisedException(
                      errCode, S.current.netWorkServerRejects);
                }
              case 404:
                {
                  return UnauthorisedException(
                      errCode, S.current.netWorkConnectionError);
                }
              case 405:
                {
                  return UnauthorisedException(
                      errCode, S.current.netWorkMethodNotAllow);
                }
              case 500:
                {
                  return UnauthorisedException(
                      errCode, S.current.netWorkServerError);
                }
              case 502:
                {
                  return UnauthorisedException(
                      errCode, S.current.netWorkInvalidRequest);
                }
              case 503:
                {
                  return UnauthorisedException(
                      errCode, S.current.netWorkServerError);
                }
              case 505:
                {
                  return UnauthorisedException(
                      errCode, S.current.netWorkUnsupportedRequest);
                }
              default:
                {
                  return ApiException(errCode, message);
                }
            }
          } on Exception catch (_) {
            return ApiException(-1, S.current.netWorkUnknownError);
          }
        }
      default:
        {
          return ApiException(-1, S.current.netWorkUnknownError);
        }
    }
  }
}

/// 请求错误
class BadRequestException extends ApiException {
  BadRequestException([int? code, String? message]) : super(code, message);
}

///未知异常
class UnauthorisedException extends ApiException {
  UnauthorisedException([int? code = -1, String? message])
      : super(code, message);
}

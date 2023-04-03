import 'package:dio/dio.dart';
import 'package:kayndrexsphere_mobile/Data/utils/http_utils_string.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = HttpErrorStrings.operationCancelled;
        break;
      case DioErrorType.connectionTimeout:
        message = HttpErrorStrings.connectionTimeoutActive;
        break;
      case DioErrorType.receiveTimeout:
        message = HttpErrorStrings.receiveTimeout;
        break;
      case DioErrorType.badResponse:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioErrorType.sendTimeout:
        message = HttpErrorStrings.sendTimeout;
        break;
      case DioErrorType.unknown:
        if (dioError.error.toString().contains("SocketException")) {
          message = HttpErrorStrings.genericRes;
          break;
        }
        message = HttpErrorStrings.uknown;
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }
  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return error['message'];
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}

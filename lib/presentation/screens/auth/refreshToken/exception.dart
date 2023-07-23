import 'package:dio/dio.dart';

class GenericException implements Exception {
  GenericException.fromDioError(DioExceptionType dioError) {
    switch (dioError) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.connectionError:
        message = "Connection to API server failed due to internet connection";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        //TODO:remove the comment tag below
        // message = _handleError(dioError.response!.statusCode!);
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  late String message;

  String _handleError(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 404:
        return 'The requested resource was not found';
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}

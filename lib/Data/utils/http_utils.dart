// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:kayndrexsphere_mobile/Data/utils/connection.dart';
// import 'package:kayndrexsphere_mobile/Data/utils/http_utils_string.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// class HttpUtils {
//   static final BaseOptions options = BaseOptions(
//     connectTimeout: const Duration(milliseconds: 999990),
//     receiveTimeout: const Duration(milliseconds: 89250),
//   );

//   static Dio getInstance() {
//     Dio dio = Dio(options)
//       ..interceptors.add(PrettyDioLogger(
//           requestBody: true,
//           requestHeader: true,
//           responseBody: true,
//           responseHeader: false,
//           compact: false,
//           error: true,
//           maxWidth: 90));
//     return dio;
//   }

//   static Future<DioError?> buildErrorResponse(DioError err) async {
//     switch (err.type) {
//       case DioErrorType.connectionTimeout:
//         if (await ConnectionUtils.getActiveStatus()) {
//           HttpErrorStrings.CONNECTION_TIMEOUT_ACTIVE;
//         } else {
//           HttpErrorStrings.CONNECTION_TIMEOUT_NOT_ACTIVE;
//         }
//         break;
//       case DioErrorType.sendTimeout:
//         HttpErrorStrings.SEND_TIMEOUT;
//         break;
//       case DioErrorType.receiveTimeout:
//         HttpErrorStrings.RECEIVE_TIMEOUT;
//         break;
//       case DioErrorType.badResponse:
//         if (err.response!.statusCode == HttpStatus.badRequest) {
//           err.response!.data.toString();
//         } else if (err.response!.statusCode == HttpStatus.unauthorized) {
//           'Unauthorized';
//         } else {
//           HttpErrorStrings.BAD_RESPONSE;
//         }
//         break;
//       case DioErrorType.cancel:
//         HttpErrorStrings.OPERATION_CANCELLED;
//         break;
//       case DioErrorType.unknown:
//         HttpErrorStrings.UNKNOWN;
//         break;
//       case DioErrorType.connectionError:
//         if (!await ConnectionUtils.getActiveStatus()) {
//           HttpErrorStrings.DEFAULT;
//         } else {
//           HttpErrorStrings.BAD_RESPONSE;
//         }
//         break;
//       default:
//         HttpErrorStrings.UNKNOWN;
//         break;
//     }

//     return err;
//   }
// }

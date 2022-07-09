// import 'package:dio/dio.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
// import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// class Api {
//   final Dio api = Dio(BaseOptions(
//       receiveTimeout: 100000,
//       connectTimeout: 100000,
//       baseUrl: Constants.apiBaseUrl));
//   // String? accessToken;

//   // final _storage = const FlutterSecureStorage();

//   Api() {
//     api.interceptors
//         .add(InterceptorsWrapper(onRequest: (options, handler) async {
//       print("HELLO");
//       final accessToken = PreferenceManager.authToken;
//       print("I PRINTED HERE $accessToken");
//       // if (!options.path.contains('http')) {
//       //   options.path = 'http://192.168.0.20:8080' + options.path;
//       // }
//       options.headers['Authentication'] = 'Bearer $accessToken';
//       // options.headers.addAll({"Authentication": "Bearer $accessToken"});
//       print("Headering:");
//       options.headers.forEach((k, v) => print('$k: $v'));
//       if (options.queryParameters != null) {
//         print("queryParameters:");
//         options.queryParameters.forEach((k, v) => print('$k: $v'));
//       }
//       if (options.data != null) {
//         print("Body: ${options.data}");
//       }
//       print(
//           "--> END ${options.method != null ? options.method.toUpperCase() : 'METHOD'}");
//       return handler.next(options);
//     }, onError: (DioError error, handler) async {
//       print("${error.response?.statusCode}");
//       if (error.response?.statusCode == 401) {
//         print("RETRYFIRST");
//         if (PreferenceManager.refreshToken.isNotEmpty) {
//           if (await getrefreshToken()) {
//             print("RETRY");
//             return handler.resolve(await _retry(error.requestOptions));
//           }
//         }
//       }
//       return handler.next(error);
//     }));
//     api.interceptors.add(PrettyDioLogger());
//   }

//   Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
//     final options = Options(
//       method: requestOptions.method,
//       headers: requestOptions.headers,
//     );
//     return api.request<dynamic>(requestOptions.path,
//         data: requestOptions.data,
//         queryParameters: requestOptions.queryParameters,
//         options: options);
//   }

//   Future<bool> getrefreshToken() async {
//     final deviceId = PreferenceManager.deviceId;
//     final refreshToken = PreferenceManager.refreshToken;
//     // final refreshToken = await _storage.read(key: 'refreshToken');
//     final response = await api.post('/auth/refresh-tokens',
//         data: {'device_id': deviceId, 'refreshToken': refreshToken});

//     if (response.statusCode == 201) {
//       PreferenceManager.authToken = response.data;

//       return true;
//     } else {
//       // refresh token is wrong
//       // accessToken = null;
//       // _storage.deleteAll();
//       return false;
//     }
//   }
// }

// final apiProvider = Provider((ref) {
//   return Api();
// });

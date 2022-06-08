import 'package:dio/dio.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';

class ApiInterceptor extends Interceptor {
  @override
  Future<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = PreferenceManager.authToken;

    // final token = StorageUtil.getString(Constants.token);

    print(options.headers);
    if (options.headers.isEmpty) {
      options.headers.addAll({"Authentication": "Bearer $token"});
      // remove the auxilliary header
      // options.headers.remove({"Authentication": "Bearer $token"});
    } else if (options.headers.isNotEmpty) {
      options.headers.addAll({"Authentication": "Bearer $token"});
    } else {
      options.headers.remove('requireToken');
    }

    print("Headers:");
    options.headers.forEach((k, v) => print('$k: $v'));
    if (options.queryParameters != null) {
      print("queryParameters:");
      options.queryParameters.forEach((k, v) => print('$k: $v'));
    }
    if (options.data != null) {
      print("Body: ${options.data}");
    }
    print(
        "--> END ${options.method != null ? options.method.toUpperCase() : 'METHOD'}");

    // options.headers.addAll({"X-Api-Key": "${Globals.xAPIKey}"});

    return super.onRequest(options, handler);
  }
}

@override
Future onResponse(Response response, ResponseInterceptorHandler handler) async {
  // print('RESPONSE[${response.statusCode}] => PATH: ${response.request?.path}');
  print("Headers:");
  response.headers.forEach((k, v) => print('$k: $v'));
  print("Response: ${response.data}");
  print("<-- END HTTP");
  // }
  return handler.next(response);
}

import 'package:dio/dio.dart';
import 'package:kayndrexsphere_mobile/main.dart';

///chnage to extend interceptor
class ErrorInterceptor extends InterceptorsWrapper {
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    // var res = await HttpUtils.buildErrorResponse(err);

    // print("Here ${err.error}");

    if (err.response?.requestOptions.path != "/auth/sign-in" &&
        err.response?.requestOptions.path != "/auth/sign-in-new" &&
        err.response?.statusCode == 401) {
      eventBus.fire(UnAuthenticated());
    }
    return super.onError(err, handler);
  }
}

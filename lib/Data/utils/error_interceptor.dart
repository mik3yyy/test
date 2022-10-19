import 'package:dio/dio.dart';
import 'package:kayndrexsphere_mobile/Data/utils/http_utils.dart';
import 'package:kayndrexsphere_mobile/main.dart';

///chnage to extend interceptor
class ErrorInterceptor extends InterceptorsWrapper {
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    err = await HttpUtils.buildErrorResponse(err);

    if (err.response?.requestOptions.path != "/auth/sign-in") {
      if (err.response?.statusCode == 401) {
        eventBus.fire(UnAuthenticated());
      }
    }
    return super.onError(err, handler);
  }
}

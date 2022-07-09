import 'package:dio/dio.dart';
import 'package:kayndrexsphere_mobile/Data/utils/http_utils.dart';

///chnage to extend interceptor
class ErrorInterceptor extends InterceptorsWrapper {
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    err = await HttpUtils.buildErrorResponse(err);
    return super.onError(err, handler);
  }
}

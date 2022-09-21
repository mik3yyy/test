import 'package:dio/dio.dart';
import 'package:kayndrexsphere_mobile/Data/utils/error_state.dart';
import 'package:kayndrexsphere_mobile/Data/utils/http_utils.dart';
import 'package:kayndrexsphere_mobile/main.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';

///chnage to extend interceptor
class ErrorInterceptor extends InterceptorsWrapper {
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    err = await HttpUtils.buildErrorResponse(err);

    if (err.response!.requestOptions.path != "/auth/sign-in") {
      if (err.error == "Unauthorized") {
        eventBus.fire(ErrorState(error: err.error));
      }
    }

    PreferenceManager.errorMessage = err.error;
    return super.onError(err, handler);
  }
}

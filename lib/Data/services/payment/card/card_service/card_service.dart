import 'package:dio/dio.dart';
import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/failure_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/req/add_card.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/res/card_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_res.dart';
import 'package:kayndrexsphere_mobile/Data/utils/api_interceptor.dart';
import 'package:kayndrexsphere_mobile/Data/utils/error_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod/riverpod.dart';

final cardServiceProvider = Provider<CardService>((ref) {
  return CardService((ref.read));
});

final dioProvider = Provider((ref) => Dio(BaseOptions(
    receiveTimeout: 100000,
    connectTimeout: 100000,
    // contentType: "application/json-patch+json",
    baseUrl: Constants.apiBaseUrl)));

class CardService {
  final Reader _read;
  CardService(this._read) {
    _read(dioProvider).interceptors.add(ApiInterceptor());
    _read(dioProvider).interceptors.add(ErrorInterceptor());
    _read(dioProvider).interceptors.add(PrettyDioLogger());
  }

  // Fetch list of Banks
  Future<AddCardRes> addCard(AddCard addCardreq) async {
    const url = '/payments/deposits/card/new/initiate';

    try {
      final response =
          await _read(dioProvider).post(url, data: addCardreq.toJson()
              // options: Options(headers: {"Authentication": "Bearer $token"})
              );
      final result = AddCardRes.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        throw e.error;
      }
    }
  }
}

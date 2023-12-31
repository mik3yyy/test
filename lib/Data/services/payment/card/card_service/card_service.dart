import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/failure_res.dart';

import 'package:kayndrexsphere_mobile/Data/services/payment/card/req/add_card_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/res/card_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/res/get_card.dart';
import 'package:kayndrexsphere_mobile/Data/utils/api_interceptor.dart';
import 'package:kayndrexsphere_mobile/Data/utils/app_config/environment.dart';
import 'package:kayndrexsphere_mobile/Data/utils/error_handler.dart';
import 'package:kayndrexsphere_mobile/Data/utils/error_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod/riverpod.dart';

import '../../make_payment/fund_wallet/fund_wallet_req.dart';
import '../../make_payment/fund_wallet/web_res.dart';

final cardServiceProvider = Provider<CardService>((ref) {
  return CardService((ref), ref);
});

final dioProvider = Provider((ref) => Dio(BaseOptions(
    receiveTimeout: const Duration(milliseconds: 100000),
    connectTimeout: const Duration(milliseconds: 100000),
    // contentType: "application/json-patch+json",
    baseUrl: AppConfig.coreBaseUrl)));

class CardService {
  final Ref _read;
  final Ref ref;
  CardService(this._read, this.ref) {
    _read.read(dioProvider).interceptors.addAll([
      ApiInterceptor(),
      ErrorInterceptor(),
      if (kDebugMode) ...[PrettyDioLogger()]
    ]);
  }

  // FSavd Card
  Future<AddCardRes> addCard(AddCardReq addCardreq) async {
    const url = '/payments/deposits/card/new/initiate';

    try {
      final response =
          await _read.read(dioProvider).post(url, data: addCardreq.toJson()
              // options: Options(headers: {"Authentication": "Bearer $token"})
              );
      final result = AddCardRes.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        throw errorMessage;
      }
    }
  }

  Future<GetCardRes> getSavedCard() async {
    const url = '/cards';

    try {
      final response = await _read.read(dioProvider).get(
            url,
            // options: Options(headers: {"Authentication": "Bearer $token"})
          );
      final result = GetCardRes.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        throw errorMessage;
      }
    }
  }

  //* Set card has default has not be done yet
  Future<GetCardRes> setCardAsDefault(String cardID) async {
    const url = '/cards/set-default';

    try {
      final response =
          await _read.read(dioProvider).post(url, data: {"card": cardID}
              // options: Options(headers: {"Authentication": "Bearer $token"})
              );
      final result = GetCardRes.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        throw errorMessage;
      }
    }
  }

  Future<StripeWebRes> fundWallet(FundWalletReq fundWalletReq) async {
    const url = '/payments/deposits/new/initiate-web';
    try {
      final response =
          await _read.read(dioProvider).post(url, data: fundWalletReq.toJson());
      final result = StripeWebRes.fromJson(response.data);

      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        if (e.response?.statusCode == 500) {
          throw "An Error occurred please try again";
        } else {
          Failure result = Failure.fromJson(e.response!.data);
          throw result.message!;
        }
      } else {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        throw errorMessage;
      }
    }
  }

//* Authorize card
  Future<AddCardRes> authorize(AddCardReq addCardReq) async {
    const url = '/payments/deposits/card/new/authorize';

    try {
      final response =
          await _read.read(dioProvider).post(url, data: addCardReq.toJson()
              // options: Options(headers: {"Authentication": "Bearer $token"})
              );
      final result = AddCardRes.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        throw errorMessage;
      }
    }
  }
}

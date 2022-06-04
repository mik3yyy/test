import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/failure_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/create_wallet_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/set_default_as_wallet_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/user_account_details_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/wallet_transactions.dart';
import 'package:kayndrexsphere_mobile/Data/utils/api_interceptor.dart';
import 'package:kayndrexsphere_mobile/Data/utils/error_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final walletServiceProvider = Provider<WalletService>((ref) {
  return WalletService((ref.read));
});

final dioProvider = Provider((ref) => Dio(BaseOptions(
    receiveTimeout: 100000,
    connectTimeout: 100000,
    // contentType: "application/json-patch+json",
    baseUrl: Constants.apiBaseUrl)));

class WalletService {
  final Reader _read;
  WalletService(this._read) {
    _read(dioProvider).interceptors.add(ApiInterceptor());
    _read(dioProvider).interceptors.add(ErrorInterceptor());
    _read(dioProvider).interceptors.add(PrettyDioLogger());
  }

//Create Wallet for user
  Future<CreateWalletRes> createWallet(String currency) async {
    const url = '/wallets/create';
    // final pseudoToken = PreferenceManager.pseudoToken;
    try {
      final response = await _read(dioProvider).post(
        url,
        data: {
          'currency': currency,
        },
        options: Options(headers: {"requireToken": true}),
      );
      final result = CreateWalletRes.fromJson(response.data);
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

//get account details for user
  Future<UserAccountDetails> getUserAccountDetails() async {
    const url = '/wallets/mine';
    try {
      final response = await _read(dioProvider).get(
        url,
        options: Options(headers: {"requireToken": true}),
      );
      final result = UserAccountDetails.fromJson(response.data);
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

//Set Wallet as default
  Future<SetWalletAsDefaultRes> setWalletAsDefault(String currency) async {
    const url = '/wallets/set-default';
    try {
      final response = await _read(dioProvider).post(
        url,
        data: {
          'currency_code': currency,
        },
        options: Options(headers: {"requireToken": true}),
      );
      final result = SetWalletAsDefaultRes.fromJson(response.data);
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

  Future<WalletTransactions> getTransactions() async {
    const url = '/wallets/transactions';
    try {
      final response = await _read(dioProvider).get(
        url,
      );
      final result = WalletTransactions.fromJson(response.data);
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

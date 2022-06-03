import 'package:dio/dio.dart';
import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/failure_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_details_req/bank_details_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_details_res/bank_details_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_res.dart';
import 'package:kayndrexsphere_mobile/Data/utils/api_interceptor.dart';
import 'package:kayndrexsphere_mobile/Data/utils/error_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod/riverpod.dart';

final withdrawServiceProvider = Provider<WithdrawalService>((ref) {
  return WithdrawalService((ref.read));
});

final dioProvider = Provider((ref) => Dio(BaseOptions(
    receiveTimeout: 100000,
    connectTimeout: 100000,
    // contentType: "application/json-patch+json",
    baseUrl: Constants.apiBaseUrl)));

class WithdrawalService {
  final Reader _read;
  WithdrawalService(this._read) {
    _read(dioProvider).interceptors.add(ApiInterceptor());
    _read(dioProvider).interceptors.add(ErrorInterceptor());
    _read(dioProvider).interceptors.add(PrettyDioLogger());
  }

  // Fetch list of Banks
  Future<BankRes> fetchBank() async {
    const url = '/payments/withdrawals/nuban/banks';

    try {
      final response = await _read(dioProvider).get(
        url,
        // options: Options(headers: {"Authentication": "Bearer $token"})
      );
      final result = BankRes.fromJson(response.data);
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

  Future<BankDetailsRes> getBankDetails(
      GetBankAccountDetails getBankAccountDetails) async {
    const url = '/payments/withdrawals/nuban/get-account-details';
    // final token = PreferenceManager.authToken;
    try {
      final response = await _read(dioProvider).post(
        url,
        data: getBankAccountDetails.toJson(),
        // options: Options(headers: {"Authentication": "Bearer $token"})
      );
      final result = BankDetailsRes.fromJson(response.data);
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

  // Future<BankDetailsRes> makePayment(
  //     GetBankAccountDetails getBankAccountDetails) async {
  //   const url = '/payments/withdrawals/nuban/get-account-details';
  //   // final token = PreferenceManager.authToken;
  //   try {
  //     final response = await _read(dioProvider).post(
  //       url,
  //       data: getBankAccountDetails.toJson(),
  //       // options: Options(headers: {"Authentication": "Bearer $token"})
  //     );
  //     final result = BankDetailsRes.fromJson(response.data);
  //     return result;
  //   } on DioError catch (e) {
  //     if (e.response != null && e.response!.data != "") {
  //       Failure result = Failure.fromJson(e.response!.data);
  //       throw result.message!;
  //     } else {
  //       throw e.error;
  //     }
  //   }
  // }
}
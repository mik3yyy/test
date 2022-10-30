import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/failure_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/create_wallet_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/currency_transactions.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/set_default_as_wallet_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/user_account_details_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/user_saved_wallet_beneficiary_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/verify_acct_no_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/wallet_transactions.dart';
import 'package:kayndrexsphere_mobile/Data/utils/api_interceptor.dart';
import 'package:kayndrexsphere_mobile/Data/utils/app_config/environment.dart';
import 'package:kayndrexsphere_mobile/Data/utils/error_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final walletServiceProvider = Provider<WalletService>((ref) {
  return WalletService((ref.read), ref);
});

final dioProvider = Provider((ref) => Dio(BaseOptions(
    receiveTimeout: 100000,
    connectTimeout: 100000,
    // contentType: "application/json-patch+json",
    baseUrl: AppConfig.coreBaseUrl)));

final cacheProvider =
    Provider((ref) => MemCacheStore(maxSize: 10485760, maxEntrySize: 1048576));
final cacheOptions = Provider((ref) => CacheOptions(
      store: ref.watch(cacheProvider),
      hitCacheOnErrorExcept: [],
      priority: CachePriority.normal,
      maxStale: const Duration(days: 5),
      // for offline behaviour
    ));

class WalletService {
  final Reader _read;
  final Ref ref;

  WalletService(this._read, this.ref) {
    _read(dioProvider).interceptors.addAll([
      ApiInterceptor(),
      ErrorInterceptor(),
      PrettyDioLogger(),
      DioCacheInterceptor(options: ref.watch(cacheOptions)),
    ]);
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

  //Transafer to other wallet
  Future<bool> transferToWallet(
    String fromCurrency,
    String toCurrency,
    num transferAmount,
    String transactionPin,
  ) async {
    const url = '/wallets/transfer-funds/to-my-other-wallet';
    try {
      final response = await _read(dioProvider).post(url, data: {
        "from_currency": fromCurrency,
        "to_currency": toCurrency,
        "transfer_amount": transferAmount,
        "transaction_pin": transactionPin
      });

      final result = response.data = true;
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

  //Transafer to other wallet
  Future<bool> transferToAnotherUser(String accountNo, String transferCurrency,
      num transferAmount, String transactionPin, bool saveAsBeneficary) async {
    const url = '/wallets/transfer-funds/to-another-user';
    try {
      final response = await _read(dioProvider).post(url, data: {
        "account_no": accountNo,
        "transfer_currency": transferCurrency,
        "transfer_amount": transferAmount,
        "transaction_pin": transactionPin,
        "add_to_beneficiaries": saveAsBeneficary,
      });

      final result = response.data = true;
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

  //Verify friend acct no
  Future<VerifyAcctNoRes> verifyAcctNo(String accountNo) async {
    const url = '/wallets/verify-account-no';
    try {
      final response = await _read(dioProvider).post(
        url,
        data: {
          'account_no': accountNo,
        },
        options: Options(headers: {"requireToken": true}),
      );
      final result = VerifyAcctNoRes.fromJson(response.data);
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

  //get user saved wallet beneficiary
  Future<UserSavedWalletBeneficiaryRes> userSavedWalletBeneficiary() async {
    const url = '/wallets/beneficiaries';
    try {
      final response = await _read(dioProvider).get(
        url,
        options: Options(headers: {"requireToken": true}),
      );
      final result = UserSavedWalletBeneficiaryRes.fromJson(response.data);
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
      final response = await _read(dioProvider).get(url,
          options: ref
              .watch(cacheOptions)
              .copyWith(
                policy: CachePolicy.refreshForceCache,
              )
              .toOptions());

      ///   REFACTOR THIS CODE
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

  Future<CurrencyTransaction> currencyTransactions(String currency) async {
    final url = '/wallets/transactions/$currency';
    try {
      final response = await _read(dioProvider).get(url,
          options: ref
              .watch(cacheOptions)
              .copyWith(
                policy: CachePolicy.refreshForceCache,
              )
              .toOptions());
      final result = CurrencyTransaction.fromJson(response.data);

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

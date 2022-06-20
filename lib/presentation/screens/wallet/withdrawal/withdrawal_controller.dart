import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/repository/card_service_manager.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/req/add_card_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/res/card_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/Nuban/nuban_use_beneficiary_model.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/beneficiary_accounts.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/repository/withdrawal_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/transaction_information/webview/card_webview.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/shared/web_view_route_name.dart';

class WithdrawalState extends Equatable {
  final List<Beneficiary> beneficiary;
  final List<Beneficiary> ababeneficiary;
  final List<Beneficiary> ibanbeneficiary;
  final AddCardReq? addCardReq;
  final AddCardRes? addCardRes;
  final bool loading;
  final bool success;
  final PassBeneficiary passBeneficiary;
  final String error;

  const WithdrawalState(
      {required this.beneficiary,
      required this.loading,
      required this.ibanbeneficiary,
      required this.ababeneficiary,
      this.addCardReq,
      this.addCardRes,
      required this.error,
      required this.passBeneficiary,
      required this.success});

  factory WithdrawalState.initial() {
    return WithdrawalState(
        beneficiary: const [],
        ababeneficiary: const [],
        ibanbeneficiary: const [],
        loading: false,
        success: false,
        error: "",
        passBeneficiary:
            PassBeneficiary(accountName: "", accountNumber: "", bankCode: ""));
  }

  WithdrawalState copyWith(
      {final List<Beneficiary>? beneficiary,
      final List<Beneficiary>? ababeneficiary,
      final List<Beneficiary>? ibanbeneficiary,
      final bool? loading,
      final bool? success,
      final AddCardReq? addCardReq,
      final AddCardRes? addCardRes,
      final PassBeneficiary? passBeneficiary,
      final String? error}) {
    return WithdrawalState(
        beneficiary: beneficiary ?? this.beneficiary,
        loading: loading ?? this.loading,
        success: success ?? this.success,
        error: error ?? this.error,
        ibanbeneficiary: this.ibanbeneficiary,
        addCardRes: addCardRes ?? this.addCardRes,
        addCardReq: addCardReq ?? this.addCardReq,
        ababeneficiary: ababeneficiary ?? this.ababeneficiary,
        passBeneficiary: passBeneficiary ?? this.passBeneficiary);
  }

  @override
  List<Object?> get props => [
        beneficiary,
        loading,
        success,
        error,
        passBeneficiary,
        ababeneficiary,
        ibanbeneficiary,
        addCardReq,
        addCardRes
      ];
}

final genericController =
    StateNotifierProvider<WithDrawalController, WithdrawalState>((ref) =>
            WithDrawalController(ref.watch(withdrawManagerProvider),
                ref.watch(cardServiceManagerProvider))

        // return WithDrawalController(
        //   ref.watch(cardServiceManagerProvider),
        //   ref.watch(withdrawManagerProvider));

        );

class WithDrawalController extends StateNotifier<WithdrawalState> {
  final WithdrawalManager withdrawalManager;
  final CardServiceManager cardServiceManager;
  WithDrawalController(this.withdrawalManager, this.cardServiceManager)
      : super(WithdrawalState.initial());

  ///Get Nuban beneficiary
  void getBeneficiaries() async {
    try {
      state = state.copyWith(loading: true);
      final res = await withdrawalManager.nubanBeneficiary();

      state = state.copyWith(beneficiary: [...res.data!.beneficiaries!]);
      state = state.copyWith(loading: false, success: true);
    } catch (e) {
      state =
          state.copyWith(loading: false, success: false, error: e.toString());
    }
  }

  ///add Card Req
  void addCardReq(AddCardReq addCardReq) {
    state = state.copyWith(addCardReq: addCardReq);

    print(state.addCardReq!.depositRef);
  }

  ///Get Aba beneficiary
  void getAbaBeneficiaries() async {
    try {
      state = state.copyWith(loading: true);
      final res = await withdrawalManager.abaBeneficiary();

      state = state.copyWith(ababeneficiary: [...res.data!.beneficiaries!]);
      state = state.copyWith(loading: false, success: true);
    } catch (e) {
      state =
          state.copyWith(loading: false, success: false, error: e.toString());
    }
  }

  ///Get Iban beneficiary

  void getIbanBeneficiaries() async {
    try {
      state = state.copyWith(loading: true);
      final res = await withdrawalManager.ibanBeneficiary();

      state = state.copyWith(ibanbeneficiary: [...res.data!.beneficiaries!]);
      state = state.copyWith(loading: false, success: true);
    } catch (e) {
      state =
          state.copyWith(loading: false, success: false, error: e.toString());
    }
  }

  /// pass beneficairy to the next screen

  void addBeneficiary(PassBeneficiary passBeneficiary) {
    state = state.copyWith(passBeneficiary: passBeneficiary);
  }

  ///Get Iban beneficiary

  void authorize(
      {required String address,
      required String city,
      required String userState,
      required String zipcode,
      required String country,
      required String depositRef,
      required String mode,
      required BuildContext context}) async {
    // final depositRef = PreferenceManager.depositRef;
    try {
      state = state.copyWith(loading: true);
      var addCardReq = AddCardReq(
          nameOnCard: state.addCardReq!.nameOnCard,
          cardNumber: state.addCardReq!.cardNumber,
          cvv: state.addCardReq!.cvv,
          depositRef: depositRef,
          expiration: state.addCardReq!.expiration,
          depositCurrencyCode: state.addCardReq!.depositCurrencyCode,
          walletCurrencyCode: state.addCardReq!.walletCurrencyCode,
          amount: state.addCardReq!.amount,
          authorization: Authorization(
              address: address,
              state: userState,
              city: city,
              mode: mode,
              country: country,
              zipcode: zipcode));

      final res = await cardServiceManager.authorize(addCardReq);
      pushNewScreen(context,
          screen: CardWebView(
            url: res.data!.url!,
            successMsg: 'Card added',
            webViewRoute: WebViewRoute.authorization,
          ));

      state = state.copyWith(loading: false, success: true);
    } catch (e) {
      state =
          state.copyWith(loading: false, success: false, error: e.toString());
    }
  }
}

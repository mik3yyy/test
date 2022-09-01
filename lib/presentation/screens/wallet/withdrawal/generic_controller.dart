import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/notification/withdrawal_request/withdrawal_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/repository/card_service_manager.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/req/add_card_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/res/card_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/res/get_card.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/Nuban/nuban_use_beneficiary_model.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/beneficiary_accounts.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/repository/withdrawal_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/transaction_information/webview/card_webview.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/shared/web_view_route_name.dart';
import 'package:kayndrexsphere_mobile/Data/services/notification/res/get_notification.dart'
    as nots;

import '../../../../Data/services/notification/repo/notification_manager.dart';

class GenericState extends Equatable {
  final List<Beneficiary> beneficiary;
  final List<Beneficiary> ababeneficiary;
  final List<Beneficiary> ibanbeneficiary;
  final List<nots.Notification> notification;
  final List<nots.Notification> oldState;
  final List<Withdrawal> withDrawalReq;
  final List<Withdrawal> oldWithDrawalState;
  final AddCardReq? addCardReq;
  final AddCardRes? addCardRes;
  final List<Cardd> cards;
  final bool loading;
  final bool notificationloading;
  final bool success;
  final int tabState;
  final PassBeneficiary passBeneficiary;
  final String error;
  final String defaultWallet;

  const GenericState(
      {required this.beneficiary,
      required this.loading,
      required this.ibanbeneficiary,
      required this.ababeneficiary,
      required this.cards,
      required this.notificationloading,
      required this.oldState,
      required this.notification,
      required this.withDrawalReq,
      required this.oldWithDrawalState,
      required this.tabState,
      required this.defaultWallet,
      this.addCardReq,
      this.addCardRes,
      required this.error,
      required this.passBeneficiary,
      required this.success});

  factory GenericState.initial() {
    return GenericState(
        beneficiary: const [],
        ababeneficiary: const [],
        ibanbeneficiary: const [],
        notification: const [],
        oldState: const [],
        withDrawalReq: const [],
        oldWithDrawalState: const [],
        cards: const [],
        loading: false,
        defaultWallet: "",
        tabState: 0,
        success: false,
        error: "",
        passBeneficiary:
            PassBeneficiary(accountName: "", accountNumber: "", bankCode: ""),
        notificationloading: false);
  }

  GenericState copyWith(
      {final List<Beneficiary>? beneficiary,
      final List<Beneficiary>? ababeneficiary,
      final List<Beneficiary>? ibanbeneficiary,
      final List<nots.Notification>? notification,
      final List<nots.Notification>? oldState,
      final List<Withdrawal>? withDrawalReq,
      final List<Withdrawal>? oldWithDrawalState,
      final List<Cardd>? cards,
      final bool? loading,
      final bool? success,
      final AddCardReq? addCardReq,
      final AddCardRes? addCardRes,
      final PassBeneficiary? passBeneficiary,
      final bool? notificationloading,
      final int? tabState,
      final String? error,
      final String? defaultWallet}) {
    return GenericState(
        beneficiary: beneficiary ?? this.beneficiary,
        loading: loading ?? this.loading,
        notificationloading: notificationloading ?? this.notificationloading,
        success: success ?? this.success,
        error: error ?? this.error,
        defaultWallet: defaultWallet ?? this.defaultWallet,
        ibanbeneficiary: this.ibanbeneficiary,
        addCardRes: addCardRes ?? this.addCardRes,
        addCardReq: addCardReq ?? this.addCardReq,
        withDrawalReq: withDrawalReq ?? this.withDrawalReq,
        oldWithDrawalState: oldWithDrawalState ?? this.oldWithDrawalState,
        cards: cards ?? this.cards,
        tabState: tabState ?? this.tabState,
        oldState: oldState ?? this.oldState,
        notification: notification ?? this.notification,
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
        notification,
        withDrawalReq,
        oldState,
        oldWithDrawalState,
        addCardReq,
        addCardRes,
        cards,
        tabState,
        notificationloading,
        defaultWallet
      ];
}

final genericController =
    StateNotifierProvider.autoDispose<GenericController, GenericState>(
        (ref) => GenericController(ref));

class GenericController extends StateNotifier<GenericState> {
  final Ref ref;
  GenericController(this.ref) : super(GenericState.initial());

  ///Get Nuban beneficiary
  void getBeneficiaries() async {
    try {
      state = state.copyWith(loading: true);
      ref.read(withdrawManagerProvider).nubanBeneficiary().then((value) {
        state = state.copyWith(beneficiary: [...value.data!.beneficiaries!]);
        state = state.copyWith(loading: false, success: true);
        return value;
      });
    } catch (e) {
      state =
          state.copyWith(loading: false, success: false, error: e.toString());
    }
  }

  ///add Card Req
  void addCardReq(AddCardReq addCardReq) {
    state = state.copyWith(addCardReq: addCardReq);
  }

  //* TabState
  void selectTab(int tabState) {
    state = state.copyWith(tabState: tabState);
  }

  //* DefaultWallet state
  void addDefault(String defaultWallet) {
    state = state.copyWith(defaultWallet: defaultWallet);
  }

  ///Get Aba beneficiary
  void getAbaBeneficiaries() async {
    try {
      state = state.copyWith(loading: true);
      ref.read(withdrawManagerProvider).abaBeneficiary().then((value) {
        state = state.copyWith(ababeneficiary: [...value.data!.beneficiaries!]);
        return value;
      });

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
      ref.read(withdrawManagerProvider).ibanBeneficiary().then((value) {
        // state =
        //     state.copyWith(ibanbeneficiary: [...value.data!.beneficiaries!]);
        return value;
      });

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

  ///Get Card

  void getCard() async {
    try {
      state = state.copyWith(loading: true);
      ref.read(cardServiceManagerProvider).getSavedCard().then((value) {
        state = state.copyWith(cards: [...value.data.cards]);
        state = state.copyWith(loading: false, success: true);
        return value;
      });
    } catch (e) {
      state =
          state.copyWith(loading: false, success: false, error: e.toString());
    }
  }

  //* Get Notifications
  void getNotification() async {
    try {
      state = state.copyWith(notificationloading: true);

      ref
          .read(notificationServiceManagerProvider)
          .getNotification()
          .then((value) {
        state = state.copyWith(
            notification: [...value.data.notifications],
            oldState: [...value.data.notifications]);
        state = state.copyWith(notificationloading: false, success: true);

        // state = state.copyWith();
      });
    } catch (e) {
      state =
          state.copyWith(loading: false, success: false, error: e.toString());
    }
  }

  //* filter search in notifications
  void filteredNots(String query) {
    final prevState = state.oldState;

    final newState = state.notification
        .where(
            (element) => element.data!.message!.toLowerCase().contains(query))
        .toList();

    if (query.isEmpty) {
      state = state.copyWith(notification: [...prevState]);
    } else {
      state = state.copyWith(notification: [...newState]);
    }
  }

  void withdrawalNotificationRequest() async {
    print(state.loading);
    try {
      state = state.copyWith(loading: true);
      ref
          .read(notificationServiceManagerProvider)
          .getWithdrawalRequest()
          .then((value) {
        state = state.copyWith(
            withDrawalReq: [...value.data.withdrawals],
            oldWithDrawalState: [...value.data.withdrawals]);
        state = state.copyWith(loading: false, success: true);
      });

      state = state.copyWith(loading: false, success: true);
    } catch (e) {
      state =
          state.copyWith(loading: false, success: false, error: e.toString());
    }
  }

  //* filter withdrawl request notifications
  void filteredWithdrawalReq(String query) {
    final prevState = state.oldState;

    final newState = state.notification
        .where(
            (element) => element.data!.message!.toLowerCase().contains(query))
        .toList();

    if (query.isEmpty) {
      state = state.copyWith(notification: [...prevState]);
    } else {
      state = state.copyWith(notification: [...newState]);
    }
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

      ref.read(cardServiceManagerProvider).authorize(addCardReq).then(
        (value) {
          pushNewScreen(context,
              screen: CardWebView(
                url: value.data!.url!,
                successMsg: 'Card added',
                webViewRoute: WebViewRoute.authorization,
              ));
        },
      );

      state = state.copyWith(loading: false, success: true);
    } catch (e) {
      state =
          state.copyWith(loading: false, success: false, error: e.toString());
    }
  }
}

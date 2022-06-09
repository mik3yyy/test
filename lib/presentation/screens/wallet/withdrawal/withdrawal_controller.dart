import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/Nuban/nuban_use_beneficiary_model.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/beneficiary_accounts.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/repository/withdrawal_manager.dart';

class WithdrawalState extends Equatable {
  final List<Beneficiary> beneficiary;
  final List<Beneficiary> ababeneficiary;
  final List<Beneficiary> ibanbeneficiary;
  final bool loading;
  final bool success;
  final PassBeneficiary passBeneficiary;
  final String error;

  const WithdrawalState(
      {required this.beneficiary,
      required this.loading,
      required this.ibanbeneficiary,
      required this.ababeneficiary,
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
      final PassBeneficiary? passBeneficiary,
      final String? error}) {
    return WithdrawalState(
        beneficiary: beneficiary ?? this.beneficiary,
        loading: loading ?? this.loading,
        success: success ?? this.success,
        error: error ?? this.error,
        ibanbeneficiary: this.ibanbeneficiary,
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
        ibanbeneficiary
      ];
}

final withdrawalController =
    StateNotifierProvider<WithDrawalController, WithdrawalState>((ref) {
  return WithDrawalController(ref.watch(withdrawManagerProvider));
});

class WithDrawalController extends StateNotifier<WithdrawalState> {
  final WithdrawalManager withdrawalManager;
  WithDrawalController(this.withdrawalManager)
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
}

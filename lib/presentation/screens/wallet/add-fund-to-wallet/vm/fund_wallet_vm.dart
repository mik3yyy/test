import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/repository/card_service_manager.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/make_payment/fund_wallet/fund_wallet_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/make_payment/fund_wallet/web_res.dart';

final fundWalletProvider =
    StateNotifierProvider.autoDispose<FundWallet, RequestState<StripeWebRes>>(
  (ref) => FundWallet(ref),
);

class FundWallet extends RequestStateNotifier<StripeWebRes> {
  final CardServiceManager _cardServiceManager;

  FundWallet(Ref ref)
      : _cardServiceManager = ref.read(cardServiceManagerProvider);

  void fundWallet(FundWalletReq fundWalletReq) =>
      makeRequest(() => _cardServiceManager.fundWallet(fundWalletReq));
}

// final fundWalletProvider =
//     StateNotifierProvider.autoDispose<FundWalletNotifier, FundWalletState>(
//         (ref) {
//   return FundWalletNotifier(ref);
// });

// class FundWalletState extends Equatable {
//   final FundWalletReq? fundWalletReq;
//   final bool loading;
//   final bool isError;
//   final bool success;
//   final String url;
//   final String error;

//   const FundWalletState(
//       {this.fundWalletReq,
//       required this.loading,
//       required this.success,
//       required this.url,
//       required this.isError,
//       required this.error});

//   factory FundWalletState.initial() {
//     return const FundWalletState(
//       error: '',
//       url: "",
//       loading: false,
//       isError: false,
//       success: false,
//     );
//   }

//   FundWalletState copyWith({
//     FundWalletReq? fundWalletReq,
//     bool? loading,
//     bool? isError,
//     String? error,
//     String? url,
//     bool? success,
//   }) {
//     return FundWalletState(
//         loading: loading ?? this.loading,
//         success: success ?? this.success,
//         isError: isError ?? this.isError,
//         url: url ?? this.url,
//         error: error ?? this.error,
//         fundWalletReq: fundWalletReq ?? this.fundWalletReq);
//   }

//   @override
//   List<Object?> get props => [isError, error, loading, success, url];
// }

// class FundWalletNotifier extends StateNotifier<FundWalletState> {
//   final Ref ref;
//   FundWalletNotifier(
//     this.ref,
//   ) : super(FundWalletState.initial());



//   void fundWallet(FundWalletReq fundWalletReq) async {
//     state = state.copyWith(
//       loading: true,
//     );

//     try {
//       // await Stripe.instance.presentPaymentSheet();

//       ref
//           .read(cardServiceManagerProvider)
//           .fundWallet(fundWalletReq)
//           .then((value) {
//         state = state.copyWith(url: value.url, loading: false);
//         // initStripPaymentSheet(value.paymentIntent.toString(),
//         //     value.customer.toString(), value.ephemeralKey.toString());
//       }).catchError((e, s) {
//         if (!mounted) return;
//         state = state.copyWith(
//           error: e.toString(),
//           loading: false,
//           success: false,
//         );
//       });

//       // state = state.copyWith(
//       //   loading: false,
//       // );
//     } catch (e) {
//       state = state.copyWith(
//         error: e.toString(),
//         loading: false,
//         success: false,
//       );
//       throw state.toString();
//     }
//   }

//   ///INITIALIZE STRIP PAYMENT SHEET

//   Future<void> initStripPaymentSheet(
//       String paymentIntent, String customerId, String ephemeralKey) async {
//     await Stripe.instance
//         .initPaymentSheet(
//             paymentSheetParameters: SetupPaymentSheetParameters(
//           customFlow: true,
//           // setupIntentClientSecret: "",
//           merchantDisplayName: 'KayndrexSphere',
//           paymentIntentClientSecret: paymentIntent,
//           customerId: customerId,
//           style: ThemeMode.dark,
//           customerEphemeralKeySecret: ephemeralKey,
//         ))
//         .whenComplete(() => displaySheet())
//         .catchError((e, s) {
//       if (!mounted) return;
//       state = state.copyWith(
//         error: e.toString(),
//         loading: false,
//       );
//     });
//   }
//   /// DISPLAY STRIPE PAYMENT SHEET
//   Future<void> displaySheet() async {
//     state = state.copyWith(
//       loading: true,
//     );
//     try {
//       await Stripe.instance.presentPaymentSheet();
//       state = state.copyWith(
//         loading: false,
//       );
//     } catch (e) {
//       print(e.toString());
//     }
//   }

// }

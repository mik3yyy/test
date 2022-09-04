import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/repository/withdrawal_manager.dart';

// final getBankProvider = StateNotifierProvider<GetBankVM, RequestState<BankRes>>(
//   (ref) => GetBankVM(ref),
// );

// class GetBankVM extends RequestStateNotifier<BankRes> {
//   final WithdrawalManager withdrawalManager;

//   GetBankVM(Ref ref) : withdrawalManager = ref.read(withdrawManagerProvider) {
//     getbank();
//   }

//   Future<RequestState<BankRes>> getbank() =>
//       makeRequest(() => withdrawalManager.fetchBank());
// }

// USED IN THE TEXT FORM FIELD TO SEARCH THE LIST OF BANKS
final bankSearchQueryStateProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});

// USED TO GET THE LIST OF BANKS FROM THE SERVER.
final bankListSearchProvider = FutureProvider.autoDispose((ref) {
  ref.maintainState = true;
  return ref.watch(withdrawManagerProvider).fetchBank();
});

// USED TO FILTER THE LIST OF BANKS
final productSearchResultProvider =
    FutureProvider.autoDispose.family<List<Datum>, String>((ref, query) {
  //GETS THE RESULT FROM THE SERVER
  final listSearch = ref.watch(bankListSearchProvider).value;
  //STORE THE RESULT AND THEN FILTER IT
  return listSearch!.data
      .where((bank) => bank.name.toLowerCase().contains(query.toLowerCase()))
      .toList();
});

//FILTER THE STORED RESULT --- THIS IS USED IN THE UI
final searchInputProvider = FutureProvider.autoDispose((ref) {
  // USED THE STATE PROVIDER FOR THE SEARCH QUERY METHOD
  final searchQuery = ref.watch(bankSearchQueryStateProvider);

  final listSearch = ref.watch(bankListSearchProvider).value;
  //USED THE BANK LIST RESULT COMING FROM THE SERVER TO CHECK IF IT RETURNS NULL OR NOT

  if (listSearch != null) {
    // RETURN SUCCESSFULL RETURN FROM THE SERVER
    return ref.watch(productSearchResultProvider(searchQuery).future);
  } else {
    // RETURN AN EMPTY LIST IF ITS NULL
    return Future.value([]);
  }
});

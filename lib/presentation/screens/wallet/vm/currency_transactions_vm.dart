import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/currency_transactions.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/repo/wallet_repo.dart';

final currencyTransactionProvider = FutureProvider.autoDispose
    .family<CurrencyTransaction, String>((ref, currency) async {
  ref.maintainState = true;

  return ref.watch(walletManagerProvider).currencyTransactions(currency);
});

// USED IN THE TEXT FORM FIELD TO SEARCH THE LIST OF BANKS
final transactionSearchQueryStateProvider =
    StateProvider.autoDispose<String>((ref) {
  return '';
});

final defaultTransactionStateProvider =
    StateProvider.autoDispose<String>((ref) {
  return '';
});

// USED TO GET THE LIST OF BANKS FROM THE SERVER.
final remoteTransactionListProvider = FutureProvider.autoDispose((ref) {
  ref.maintainState = true;
  final defaultValue = ref.watch(defaultTransactionStateProvider);
  return ref.watch(currencyTransactionProvider(defaultValue).future);
});

// USED TO FILTER THE LIST OF BANKS
final transactionSearchResultProvider =
    FutureProvider.autoDispose.family<List<Transactions>, String>((ref, query) {
  //GETS THE RESULT FROM THE SERVER
  final listSearch = ref.watch(remoteTransactionListProvider).value;
  //STORE THE RESULT AND THEN FILTER IT
  return listSearch!.data.transactions
      .where((transaction) => transaction.amount
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase()))
      .toList();
});

//FILTER THE STORED RESULT --- THIS IS USED IN THE UI
final transactionsearchInputProvider = FutureProvider.autoDispose((ref) {
  // USED THE STATE PROVIDER FOR THE SEARCH QUERY METHOD
  final searchQuery = ref.watch(transactionSearchQueryStateProvider);

  final listSearch = ref.watch(remoteTransactionListProvider).value;
  //USED THE BANK LIST RESULT COMING FROM THE SERVER TO CHECK IF IT RETURNS NULL OR NOT

  if (listSearch != null) {
    // RETURN SUCCESSFULL RETURN FROM THE SERVER
    return ref.watch(transactionSearchResultProvider(searchQuery).future);
  } else {
    // RETURN AN EMPTY LIST IF ITS NULL
    return Future.value([]);
  }
});

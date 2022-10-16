import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../Data/model/auth/res/currency_res.dart';
import '../../../../Data/services/auth/manager/auth_manager.dart';

// USED IN THE TEXT FORM FIELD TO SEARCH THE LIST OF BANKS
final currencySearchQueryStateProvider =
    StateProvider.autoDispose<String>((ref) {
  return '';
});

// USED TO GET THE LIST OF BANKS FROM THE SERVER
final remoteCurrencyProvider = FutureProvider.autoDispose((ref) async {
  ref.maintainState = true;
  return ref.watch(authManagerProvider).getCurrency();
});

// USED TO FILTER THE LIST OF BANKS
final currencySearchResultProvider =
    FutureProvider.autoDispose.family<List<Currency>, String>((ref, query) {
  //GETS THE RESULT FROM THE SERVER
  final currency = ref.watch(remoteCurrencyProvider).value;
  //STORE THE RESULT AND THEN FILTER IT
  return currency!.data.currencies
      .where((value) => value.name.toLowerCase().contains(query.toLowerCase()))
      .toList();
});

//FILTER THE STORED RESULT --- THIS IS USED IN THE UI
final searchInputProvider = FutureProvider.autoDispose((ref) {
  // USED THE STATE PROVIDER FOR THE SEARCH QUERY METHOD
  final searchQuery = ref.watch(currencySearchQueryStateProvider);

  final listSearch = ref.watch(remoteCurrencyProvider).value;
  //USED THE BANK LIST RESULT COMING FROM THE SERVER TO CHECK IF IT RETURNS NULL OR NOT

  if (listSearch != null) {
    // RETURN SUCCESSFULL RETURN FROM THE SERVER
    return ref.watch(currencySearchResultProvider(searchQuery).future);
  } else {
    // RETURN AN EMPTY LIST IF ITS NULL
    return Future.value([]);
  }
});

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/Dialog/all_dialog.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/vm/get_dialog_messages_vm.dart';

final alldialgSearchQueryProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});

// USED TO FILTER THE LIST
final dialogSearchResultProvider =
    FutureProvider.autoDispose.family<List<Datum>?, String>((ref, query) {
  //GETS THE RESULT FROM THE SERVER
  final listSearch = ref.watch(alldialogsProvider).value;
  if (listSearch == null) {
    return [];
  } else {
    //STORE THE RESULT AND THEN FILTER IT
    return listSearch.data
        ?.where((element) => element.privateDialogOtherUser!.firstName!
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
  }
});

//FILTER THE STORED RESULT --- THIS IS USED IN THE UI
final dialogInputProvider = FutureProvider.autoDispose((ref) {
  // USED THE STATE PROVIDER FOR THE SEARCH QUERY METHOD
  final searchQuery = ref.watch(alldialgSearchQueryProvider);

  final listSearch = ref.watch(alldialogsProvider).value;
  //CHECK IF LIST RESULT COMING FROM THE SERVER IS NULL OR NOT

  if (listSearch != null) {
    // RETURN SUCCESSFULL RETURN FROM THE SERVER
    return ref.watch(dialogSearchResultProvider(searchQuery).future);
  } else {
    // RETURN AN EMPTY LIST IF ITS NULL
    return Future.value([]);
  }
});

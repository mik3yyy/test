import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/contact/contact_list.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/vm/get_contacts_vm.dart';

final allContactSearchQueryProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});

// USED TO FILTER THE LIST
final contactSearchResultProvider = FutureProvider.autoDispose
    .family<List<ContactElement>?, String>((ref, query) {
  //GETS THE RESULT FROM THE SERVER
  final listSearch = ref.watch(allContactsProvider).value;
  if (listSearch == null) {
    return Future.value([]);
  } else {
    //STORE THE RESULT AND THEN FILTER IT
    return listSearch.data.contacts
        .where((element) => element.contact!.firstName!
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
  }
});

//FILTER THE STORED RESULT --- THIS IS USED IN THE UI
final contactInputProvider =
    FutureProvider.autoDispose<List<ContactElement>?>((ref) {
  // USED THE STATE PROVIDER FOR THE SEARCH QUERY METHOD
  final searchQuery = ref.watch(allContactSearchQueryProvider);
  final listSearch = ref.watch(allContactsProvider).value;
  //CHECK IF LIST RESULT COMING FROM THE SERVER IS NULL OR NOT

  if (listSearch != null) {
    // RETURN SUCCESSFULL RETURN FROM THE SERVER
    return ref.watch(contactSearchResultProvider(searchQuery).future);
  } else {
    // RETURN AN EMPTY LIST IF ITS NULL
    return Future.value([]);
  }
});

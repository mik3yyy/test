import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/forum/model/res/get_top_post_res.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/faq/vm/get_post_vm.dart';

// USED IN THE TEXT FORM FIELD TO SEARCH THE LIST OF BANKS
final faqSearchQueryStateProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});

// USED TO GET THE LIST OF BANKS FROM THE SERVER
final remoteFaqProvider = FutureProvider.autoDispose((ref) async {
  ref.keepAlive();
  return ref.watch(allPost);
});

// USED TO FILTER THE LIST OF BANKS
final remoteFaqSearchResultProvider =
    FutureProvider.autoDispose.family<List<Post>, String>((ref, query) {
  //GETS THE RESULT FROM THE SERVER
  final faqPost = ref.watch(allPost).value;
  //STORE THE RESULT AND THEN FILTER IT
  return faqPost!.data!.posts!
      .where(
          (value) => value.title!.toLowerCase().contains(query.toLowerCase()))
      .toList();
});

//FILTER THE STORED RESULT --- THIS IS USED IN THE UI
final postInputProvider = FutureProvider.autoDispose((ref) {
  // USED THE STATE PROVIDER FOR THE SEARCH QUERY METHOD
  final searchQuery = ref.watch(faqSearchQueryStateProvider);

  final listSearch = ref.watch(allPost).value;
  //USED THE BANK LIST RESULT COMING FROM THE SERVER TO CHECK IF IT RETURNS NULL OR NOT

  if (listSearch != null) {
    // RETURN SUCCESSFULL RETURN FROM THE SERVER
    return ref.watch(remoteFaqSearchResultProvider(searchQuery).future);
  } else {
    // RETURN AN EMPTY LIST IF ITS NULL
    return Future.value([]);
  }
});

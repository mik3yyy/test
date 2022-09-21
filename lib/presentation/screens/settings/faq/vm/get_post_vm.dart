import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/forum/model/res/get_top_post_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/forum/model/res/single_post_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/forum/repo/forum_repo.dart';

final topPost = FutureProvider.autoDispose<GetPostsRes>((ref) async {
  final topPostRepository = ref.read(forumManagerProvider);

  return await topPostRepository.getTop10Posts();
});

final allPost = FutureProvider.autoDispose<GetPostsRes>((ref) async {
  final topPostRepository = ref.read(forumManagerProvider);

  return await topPostRepository.getAllPosts();
});

final fetchSinglePost = FutureProvider.autoDispose
    .family<SinglePostRes, String>((ref, postId) async {
  final fetchSinglePostRepository = ref.read(forumManagerProvider);

  return await fetchSinglePostRepository.fetchSinglePost(postId);
});
// finPostVm =
//     StateNotifierProvider.autoDispose<GetPostVM, RequestState<GetPostsRes>>(
//   (ref) => GetPostVM(ref),
// );

// class GetPostVM extends RequestStateNotifier<GetPostsRes> {
//   final ForumRepo _forumRepo;

//   GetPostVM(Ref ref) : _forumRepo = ref.read(forumManagerProvider) {
//     getTop10Posts();
//   }

//   void getTop10Posts() => makeRequest(() => _forumRepo.getTop10Posts());
// }

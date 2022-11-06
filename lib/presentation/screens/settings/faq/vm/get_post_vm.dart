import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/forum/model/res/get_top_post_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/forum/model/res/single_post_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/forum/repo/forum_repo.dart';

final topPost = FutureProvider.autoDispose<GetPostsRes>((ref) async {
  // final topPostRepository = ref.read(forumManagerProvider);
  ref.maintainState = true;
  return ref.watch(forumManagerProvider).getTop10Posts();
});

final allPost = FutureProvider<GetPostsRes>((ref) async {
  final topPostRepository = ref.read(forumManagerProvider);

  return await topPostRepository.getAllPosts();
});

final fetchSinglePost = FutureProvider.autoDispose
    .family<SinglePostRes, String>((ref, postId) async {
  final fetchSinglePostRepository = ref.read(forumManagerProvider);

  return await fetchSinglePostRepository.fetchSinglePost(postId);
});

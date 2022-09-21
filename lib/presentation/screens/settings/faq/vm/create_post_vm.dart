import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/forum/model/req/create_post_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/forum/model/res/get_top_post_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/forum/repo/forum_repo.dart';

final createPostVm =
    StateNotifierProvider.autoDispose<CreatePostVM, RequestState<GetPostsRes>>(
  (ref) => CreatePostVM(ref),
);

class CreatePostVM extends RequestStateNotifier<GetPostsRes> {
  final ForumRepo _forumRepo;

  CreatePostVM(Ref ref) : _forumRepo = ref.read(forumManagerProvider);

  void createPost(CreatePostReq createPostReq) =>
      makeRequest(() => _forumRepo.createPost(createPostReq));
}

final reactToPostVm = StateNotifierProvider<ReactToPostVM, RequestState<bool>>(
  (ref) => ReactToPostVM(ref),
);

class ReactToPostVM extends RequestStateNotifier<bool> {
  final ForumRepo _forumRepo;

  ReactToPostVM(Ref ref) : _forumRepo = ref.read(forumManagerProvider);

  void reactToPost(String postId, String reaction) =>
      makeRequest(() => _forumRepo.reactToPost(postId, reaction));
}

final unReactToPostVm =
    StateNotifierProvider<UnReactToPostVM, RequestState<bool>>(
  (ref) => UnReactToPostVM(ref),
);

class UnReactToPostVM extends RequestStateNotifier<bool> {
  final ForumRepo _forumRepo;

  UnReactToPostVM(Ref ref) : _forumRepo = ref.read(forumManagerProvider);
  void unReactToPost(String postId) =>
      makeRequest(() => _forumRepo.unReactToPost(postId));
}

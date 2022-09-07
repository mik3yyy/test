import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/forum/forum_service.dart';
import 'package:kayndrexsphere_mobile/Data/services/forum/model/res/get_top_post_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/forum/model/req/create_post_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/forum/model/res/single_post_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/forum/repo/i_forum_repo.dart';

final forumManagerProvider = Provider<ForumRepo>((ref) {
  final forumService = ref.watch(forumServiceProvider);

  return ForumRepo(forumService);
});

class ForumRepo extends IForumRepo {
  final ForumService _forumService;

  ForumRepo(this._forumService);

  @override
  Future<GetPostsRes> createPost(CreatePostReq createPostReq) async {
    return await _forumService.createPost(createPostReq);
  }

  @override
  Future<SinglePostRes> fetchSinglePost(String postId) async {
    return await _forumService.fetchSinglePost(postId);
  }

  @override
  Future<GetPostsRes> getAllPosts() async {
    return await _forumService.getAllPosts();
  }

  @override
  Future<GetPostsRes> getAllPostsPaginated(num page) async {
    return await _forumService.getAllPostsPaginated(page);
  }

  @override
  Future<GetPostsRes> getTop10Posts() async {
    return await _forumService.getTop10Posts();
  }

  @override
  Future<bool> reactToPost(String postId, String reaction) async {
    return await _forumService.reactToPost(postId, reaction);
  }

  @override
  Future<bool> unReactToPost(String postId) async {
    return await _forumService.unReactToPost(postId);
  }
}

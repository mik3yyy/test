import 'package:kayndrexsphere_mobile/Data/services/forum/model/req/create_post_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/forum/model/res/get_top_post_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/forum/model/res/single_post_res.dart';

abstract class IForumRepo {
  Future<GetPostsRes> createPost(CreatePostReq createPostReq);
  Future<GetPostsRes> getTop10Posts();
  Future<GetPostsRes> getAllPosts();
  Future<GetPostsRes> getAllPostsPaginated(num page);
  Future<SinglePostRes> fetchSinglePost(String postId);
  Future<bool> reactToPost(String postId, String reaction);
  Future<bool> unReactToPost(String postId);
}

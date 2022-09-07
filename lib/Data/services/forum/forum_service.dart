import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/failure_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/forum/model/req/create_post_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/forum/model/res/get_top_post_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/forum/model/res/single_post_res.dart';
import 'package:kayndrexsphere_mobile/Data/utils/api_interceptor.dart';
import 'package:kayndrexsphere_mobile/Data/utils/error_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final forumServiceProvider = Provider<ForumService>((ref) {
  return ForumService((ref.read), ref);
});

final dioProvider = Provider((ref) => Dio(BaseOptions(
    receiveTimeout: 100000,
    connectTimeout: 100000,
    // contentType: "application/json-patch+json",
    baseUrl: Constants.apiBaseUrl)));

class ForumService {
  final Reader _read;
  final Ref ref;
  ForumService(this._read, this.ref) {
    _read(dioProvider).interceptors.add(ApiInterceptor());
    _read(dioProvider).interceptors.add(ErrorInterceptor());
    _read(dioProvider).interceptors.add(PrettyDioLogger());
  }

  //create Post
  Future<GetPostsRes> createPost(CreatePostReq createPostReq) async {
    const url = '/forum/posts';
    try {
      final response = await _read(dioProvider).post(
        url,
        data: createPostReq.toJson(),
        options: Options(headers: {"requireToken": true}),
      );
      final result = GetPostsRes.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        throw e.error;
      }
    }
  }

  //get top 10 posts
  Future<GetPostsRes> getTop10Posts() async {
    const url = '/forum/posts/top';
    try {
      final response = await _read(dioProvider).get(
        url,
        options: Options(headers: {"requireToken": true}),
      );
      final result = GetPostsRes.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        throw e.error;
      }
    }
  }

  //get all posts
  Future<GetPostsRes> getAllPosts() async {
    const url = '/forum/posts';
    try {
      final response = await _read(dioProvider).get(
        url,
        options: Options(headers: {"requireToken": true}),
      );
      final result = GetPostsRes.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        throw e.error;
      }
    }
  }

  //get  posts pagination
  Future<GetPostsRes> getAllPostsPaginated(num page) async {
    const url = '/forum/posts/paginated';
    try {
      final response = await _read(dioProvider).get(
        url,
        queryParameters: {
          'page': page,
        },
        options: Options(headers: {"requireToken": true}),
      );
      final result = GetPostsRes.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        throw e.error;
      }
    }
  }

  //fetch single Post
  Future<SinglePostRes> fetchSinglePost(String postId) async {
    const url = '/forum/posts/fetch-one';
    try {
      final response = await _read(dioProvider).post(
        url,
        data: {"post_id": postId},
        options: Options(headers: {"requireToken": true}),
      );
      final result = SinglePostRes.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        throw e.error;
      }
    }
  }

  //react to a Post
  Future<bool> reactToPost(String postId, String reaction) async {
    const url = '/forum/posts/react';
    try {
      final response = await _read(dioProvider).post(
        url,
        data: {"post_id": postId, "reaction": reaction},
        options: Options(headers: {"requireToken": true}),
      );

      return response.data = true;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        throw e.error;
      }
    }
  }

  //unreact to a Post
  Future<bool> unReactToPost(String postId) async {
    const url = '/forum/posts/react/un-react';
    try {
      final response = await _read(dioProvider).post(
        url,
        data: {"post_id": postId},
        options: Options(headers: {"requireToken": true}),
      );
      return response.data = true;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        Failure result = Failure.fromJson(e.response!.data);
        throw result.message!;
      } else {
        throw e.error;
      }
    }
  }
}

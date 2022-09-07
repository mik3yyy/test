// To parse this JSON data, do
//
//     final getPostsRes = getPostsResFromJson(jsonString);

import 'dart:convert';

GetPostsRes getPostsResFromJson(String str) =>
    GetPostsRes.fromJson(json.decode(str));

String getPostsResToJson(GetPostsRes data) => json.encode(data.toJson());

class GetPostsRes {
  GetPostsRes({
    this.message,
    this.status,
    this.data,
  });

  String? message;
  String? status;
  Data? data;

  factory GetPostsRes.fromJson(Map<String, dynamic> json) => GetPostsRes(
        message: json["message"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.posts,
  });

  List<Post>? posts;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        posts: json["posts"] == null
            ? []
            : List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "posts": List<dynamic>.from(posts!.map((x) => x.toJson())),
      };
}

class Post {
  Post({
    this.postId,
    this.title,
    this.text,
    this.status,
    this.dateLastEdited,
    required this.createdAt,
    this.updatedAt,
    this.noOfDislikes,
    this.noOfLikes,
    this.comments,
  });

  String? postId;
  String? title;
  String? text;
  String? status;
  dynamic dateLastEdited;
  DateTime createdAt;
  DateTime? updatedAt;
  num? noOfDislikes;
  num? noOfLikes;
  List<dynamic>? comments;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        postId: json["post_id"] ?? '',
        title: json["title"] ?? '',
        text: json["text"] ?? '',
        status: json["status"] ?? '',
        dateLastEdited: json["date_last_edited"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        noOfDislikes: json["no_of_dislikes"] ?? 0,
        noOfLikes: json["no_of_likes"] ?? 0,
        comments: json["updatedAt"] == null
            ? []
            : List<dynamic>.from(json["comments"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "post_id": postId,
        "title": title,
        "text": text,
        "status": status,
        "date_last_edited": dateLastEdited,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "no_of_dislikes": noOfDislikes,
        "no_of_likes": noOfLikes,
        "comments": List<dynamic>.from(comments!.map((x) => x)),
      };
}

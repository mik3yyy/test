// To parse this JSON data, do
//
//     final singlePostRes = singlePostResFromJson(jsonString);

import 'dart:convert';

SinglePostRes singlePostResFromJson(String str) =>
    SinglePostRes.fromJson(json.decode(str));

String singlePostResToJson(SinglePostRes data) => json.encode(data.toJson());

class SinglePostRes {
  SinglePostRes({
    this.message,
    this.status,
    this.data,
  });

  String? message;
  String? status;
  Data? data;

  factory SinglePostRes.fromJson(Map<String, dynamic> json) => SinglePostRes(
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
    this.postId,
    this.title,
    this.text,
    this.status,
    this.dateLastEdited,
    this.createdAt,
    this.updatedAt,
    this.currentUserReaction,
    this.noOfDislikes,
    this.noOfLikes,
    this.comments,
  });

  String? postId;
  String? title;
  String? text;
  String? status;
  dynamic dateLastEdited;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic currentUserReaction;
  num? noOfDislikes;
  num? noOfLikes;
  List<dynamic>? comments;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        postId: json["post_id"] ?? "",
        title: json["title"] ?? "",
        text: json["text"] ?? "",
        status: json["status"] ?? "",
        dateLastEdited: json["date_last_edited"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        currentUserReaction: json["current_user_reaction"],
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
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "current_user_reaction": currentUserReaction,
        "no_of_dislikes": noOfDislikes,
        "no_of_likes": noOfLikes,
        "comments": List<dynamic>.from(comments!.map((x) => x)),
      };
}

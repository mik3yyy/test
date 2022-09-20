// To parse this JSON data, do
//
//     final createPostReq = createPostReqFromJson(jsonString);

import 'dart:convert';

CreatePostReq createPostReqFromJson(String str) =>
    CreatePostReq.fromJson(json.decode(str));

String createPostReqToJson(CreatePostReq data) => json.encode(data.toJson());

class CreatePostReq {
  CreatePostReq({
    required this.title,
    required this.text,
  });

  String title;
  String text;

  factory CreatePostReq.fromJson(Map<String, dynamic> json) => CreatePostReq(
        title: json["title"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "text": text,
      };
}

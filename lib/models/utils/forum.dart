// ignore_for_file: camel_case_types


import 'package:e_learning/models/user.dart';

class forums {
  int? id;
  String? body;
  int? likesCount;
  int? commentsCount;
  User? user;
  bool? selfLiked;

  forums({
    this.id,
    this.body,
    this.likesCount,
    this.commentsCount,
    this.user,
    this.selfLiked,
  });

// map json to post model

factory forums.fromJson(Map<String, dynamic> json) {
  return forums(
    id: json['id'],
    body: json['body'],
    likesCount: json['likes_count'],
    commentsCount: json['comments_count'],
    selfLiked: json['likes'].length > 0,
    user: User(
      id: json['user']['id'],
      name: json['user']['name'],
    )
  );
}

}
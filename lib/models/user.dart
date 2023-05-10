import 'package:flutter/material.dart';

class User {
  int? id;
  String? name;
  String? image;
  String? email;
  String? token;
  String?department;

  User({
    this.id,
    this.name,
    this.image,
    this.email,
    this.department,
    this.token,
 
  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['user']['id'],
      name: json['user']['name'],
      image: json['user']['image'],
      email: json['user']['email'],
      department: json['user']['department'],
      token: json['token']
    );
  }
}
class AgoraUser {
  int uid;
  bool isMuted;
  bool isVideoDisabled;
  String? name;
  Color? color;
  AgoraUser({
    required this.uid,
    this.isMuted = false,
    this.isVideoDisabled = false,
    this.name,
    this.color,
  });
  AgoraUser copyWith({
    int? uid,
    bool? isMuted,
    bool? isVideoDisabled,
    String? name,
    Color? color,
  }) {
    return AgoraUser(
      uid: uid ?? this.uid,
      isMuted: isMuted ?? this.isMuted,
      isVideoDisabled: isVideoDisabled ?? this.isVideoDisabled,
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }
}
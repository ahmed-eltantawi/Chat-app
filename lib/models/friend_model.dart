import 'package:flutter/foundation.dart';

class FriendModel {
  final String name;

  FriendModel({required this.name});

  factory FriendModel.fromJson(json) {
    return FriendModel(name: json['name']);
  }
}

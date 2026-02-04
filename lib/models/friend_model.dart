import 'package:flutter/foundation.dart';

class FriendModel {
  final String name;
  final String id;

  FriendModel({required this.name, required this.id});

  factory FriendModel.fromJson(json) {
    return FriendModel(name: json['name'], id: json['id']);
  }
}

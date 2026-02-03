import 'package:flutter/foundation.dart';

class MassageModel {
  String massage;
  String id;

  MassageModel({required this.massage, required this.id});
  factory MassageModel.fromJson(json) {
    return MassageModel(massage: json['text'], id: json['id']);
  }
}

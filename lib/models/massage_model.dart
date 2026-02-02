import 'package:flutter/foundation.dart';

class MassageModel {
  String massage;

  MassageModel({required this.massage});
  factory MassageModel.fromJson(json) {
    return MassageModel(massage: json['text']);
  }
}

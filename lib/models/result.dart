import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'result.g.dart';

@HiveType(typeId: 2)
class Result {
  @HiveField(0)
  int? id;
  @HiveField(1)
  double? confidence;
  @HiveField(2)
  String? label;
  @HiveField(3)
  String? date;
  @HiveField(4)
  Uint8List? leftEyeImg;
  @HiveField(5)
  Uint8List? rightEyeImg;
  @HiveField(6)
  String? uid;

  Result(this.confidence, this.id, this.label) {
    date = DateTime.now().toString();
  }

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    confidence = json['confidence'];
    label = json['label'];
    date = json['date'];
    leftEyeImg = json['leftEyeImg'];
    rightEyeImg = json['rightEyeImg'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['confidence'] = confidence;
    data['label'] = label;
    data['date'] = date;
    data['leftEyeImg'] = leftEyeImg;
    data['rightEyeImg'] = rightEyeImg;
    data['uid'] = uid;
    return data;
  }
}

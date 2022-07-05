import 'dart:convert';

import 'package:test_get/generated/json/base/json_field.dart';
import 'package:test_get/generated/json/user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  late String account;
  late String nickname;
  late String avatar;
  late int age;
  late int gender;

  UserEntity();

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      $UserEntityFromJson(json);

  Map<String, dynamic> toJson() => $UserEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

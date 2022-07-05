import 'dart:convert';

import 'package:test_get/generated/json/base/json_field.dart';
import 'package:test_get/generated/json/goods_entity.g.dart';

@JsonSerializable()
class GoodsEntity {
  late String id;
  late String picture;
  late String name;
  late String desc;
  late int price;
  late int like;

  GoodsEntity();

  factory GoodsEntity.fromJson(Map<String, dynamic> json) =>
      $GoodsEntityFromJson(json);

  Map<String, dynamic> toJson() => $GoodsEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

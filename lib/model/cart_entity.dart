import 'dart:convert';

import 'package:test_get/generated/json/base/json_field.dart';
import 'package:test_get/generated/json/cart_entity.g.dart';
import 'package:test_get/model/goods_entity.dart';

@JsonSerializable()
class CartEntity{
  late GoodsEntity goodsEntity;
  late int quantity;
  late bool checked;

  CartEntity();

  factory CartEntity.fromJson(Map<String, dynamic> json) =>
      $CartEntityFromJson(json);

  Map<String, dynamic> toJson() => $CartEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
import 'package:test_get/generated/json/base/json_convert_content.dart';
import 'package:test_get/model/cart_entity.dart';
import 'package:test_get/model/goods_entity.dart';


CartEntity $CartEntityFromJson(Map<String, dynamic> json) {
	final CartEntity cartEntity = CartEntity();
	final GoodsEntity? goodsEntity = jsonConvert.convert<GoodsEntity>(json['goodsEntity']);
	if (goodsEntity != null) {
		cartEntity.goodsEntity = goodsEntity;
	}
	final int? quantity = jsonConvert.convert<int>(json['quantity']);
	if (quantity != null) {
		cartEntity.quantity = quantity;
	}
	final bool? checked = jsonConvert.convert<bool>(json['checked']);
	if (checked != null) {
		cartEntity.checked = checked;
	}
	return cartEntity;
}

Map<String, dynamic> $CartEntityToJson(CartEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['goodsEntity'] = entity.goodsEntity.toJson();
	data['quantity'] = entity.quantity;
	data['checked'] = entity.checked;
	return data;
}
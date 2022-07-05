import 'package:test_get/generated/json/base/json_convert_content.dart';
import 'package:test_get/model/goods_entity.dart';

GoodsEntity $GoodsEntityFromJson(Map<String, dynamic> json) {
	final GoodsEntity goodsEntity = GoodsEntity();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		goodsEntity.id = id;
	}
	final String? picture = jsonConvert.convert<String>(json['picture']);
	if (picture != null) {
		goodsEntity.picture = picture;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		goodsEntity.name = name;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		goodsEntity.desc = desc;
	}
	final int? price = jsonConvert.convert<int>(json['price']);
	if (price != null) {
		goodsEntity.price = price;
	}
	final int? like = jsonConvert.convert<int>(json['like']);
	if (like != null) {
		goodsEntity.like = like;
	}
	return goodsEntity;
}

Map<String, dynamic> $GoodsEntityToJson(GoodsEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['picture'] = entity.picture;
	data['name'] = entity.name;
	data['desc'] = entity.desc;
	data['price'] = entity.price;
	data['like'] = entity.like;
	return data;
}
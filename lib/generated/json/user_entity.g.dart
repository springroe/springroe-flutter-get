import 'package:test_get/generated/json/base/json_convert_content.dart';
import 'package:test_get/model/user_entity.dart';

UserEntity $UserEntityFromJson(Map<String, dynamic> json) {
	final UserEntity userEntity = UserEntity();
	final String? account = jsonConvert.convert<String>(json['account']);
	if (account != null) {
		userEntity.account = account;
	}
	final String? nickname = jsonConvert.convert<String>(json['nickname']);
	if (nickname != null) {
		userEntity.nickname = nickname;
	}
	final String? avatar = jsonConvert.convert<String>(json['avatar']);
	if (avatar != null) {
		userEntity.avatar = avatar;
	}
	final int? age = jsonConvert.convert<int>(json['age']);
	if (age != null) {
		userEntity.age = age;
	}
	final int? gender = jsonConvert.convert<int>(json['gender']);
	if (gender != null) {
		userEntity.gender = gender;
	}
	return userEntity;
}

Map<String, dynamic> $UserEntityToJson(UserEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['account'] = entity.account;
	data['nickname'] = entity.nickname;
	data['avatar'] = entity.avatar;
	data['age'] = entity.age;
	data['gender'] = entity.gender;
	return data;
}
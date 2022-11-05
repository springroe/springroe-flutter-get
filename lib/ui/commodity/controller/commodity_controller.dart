import 'package:get/get.dart';
import 'package:test_get/model/goods_entity.dart';

class CommodityController extends GetxController {
  static CommodityController get instance => Get.find();

  var commodity = GoodsEntity().obs;
}

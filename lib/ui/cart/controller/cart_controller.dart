import 'package:get/get.dart';
import 'package:test_get/model/cart_entity.dart';
import 'package:test_get/model/goods_entity.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  RxList<CartEntity> commodities = <CartEntity>[].obs;

  var selectAll = false.obs;

  var total = 0.obs;

  addCommodity(GoodsEntity goodsEntity) {
    int index = commodities
        .indexWhere((element) => element.goodsEntity.name == goodsEntity.name);
    if (index > -1) {
      CartEntity cartEntity = commodities[index];
      cartEntity.quantity = cartEntity.quantity + 1;
      commodities[index] = cartEntity;
    } else {
      CartEntity cartEntity = CartEntity();
      cartEntity.goodsEntity = goodsEntity;
      cartEntity.quantity = 1;
      cartEntity.checked = false;
      commodities.add(cartEntity);
    }
  }

  removeCommodity(int index) {
    commodities.removeAt(index);
  }

  selectChange(int index) {
    CartEntity cartEntity = commodities[index];
    cartEntity.checked = !cartEntity.checked;
    commodities[index] = cartEntity;
    selectAll(commodities.every((element) => element.checked));
    _countSum();
  }

  selectAllChange() {
    commodities(commodities.map((element) {
      element.checked = !selectAll.value;
      return element;
    }).toList());
    selectAll(!selectAll.value);
    _countSum();
  }

  quantityAdd(int index) {
    CartEntity cartEntity = commodities[index];
    cartEntity.quantity = cartEntity.quantity += 1;
    commodities[index] = cartEntity;
    _countSum();
  }

  quantityMinus(int index) {
    CartEntity cartEntity = commodities[index];
    cartEntity.quantity = cartEntity.quantity -= 1;
    commodities[index] = cartEntity;
    _countSum();
  }

  _countSum() {
    total(commodities.map((element) {
      return element.checked ? element.goodsEntity.price * element.quantity : 0;
    }).reduce((previousValue, element) => previousValue + element));
  }
}

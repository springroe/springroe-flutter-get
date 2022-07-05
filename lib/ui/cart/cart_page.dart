import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:test_get/model/cart_entity.dart';
import 'package:test_get/ui/cart/controller/cart_controller.dart';
import 'package:test_get/utils/number_util.dart';
import 'package:test_get/widget/button/image_check_box.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CartController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shopping Cart',
          style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          _cartList(),
          _priceBar(),
        ],
      ),
    );
  }

  Widget _cartList() {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 60,
      child: Obx(
        () => ListView.separated(
            itemBuilder: (context, index) {
              return _cartItem(
                  context, CartController.instance.commodities[index], index);
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 3,
                indent: 0,
              );
            },
            itemCount: CartController.instance.commodities.length),
      ),
    );
  }

  Widget _cartItem(BuildContext context, CartEntity cartEntity, int index) {
    return SizedBox(
      height: 80,
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (c) {
                _deleteItem(context, index);
              },
              backgroundColor: const Color(0xFF7BC043),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          color: Colors.grey[100],
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              ImageCheckBox(
                  check: cartEntity.checked,
                  onChange: (value) =>
                      CartController.instance.selectChange(index)),
              const SizedBox(
                width: 12,
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: Image.asset(
                  cartEntity.goodsEntity.picture,
                  width: 60,
                  height: 60,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        cartEntity.goodsEntity.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Amount: \$${NumberUtil.priceFormat(cartEntity.goodsEntity.price)}',
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (CartController.instance.commodities[index]
                                          .quantity >
                                      1) {
                                    CartController.instance
                                        .quantityMinus(index);
                                  } else {
                                    _deleteItem(context, index);
                                  }
                                },
                                child: Image.asset(
                                  'assets/goods/ic_cart_quantity_minus.png',
                                  color: Colors.pink,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              SizedBox(
                                width: 30,
                                child: Center(
                                  child: Text('${cartEntity.quantity}'),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  CartController.instance.quantityAdd(index);
                                },
                                child: Image.asset(
                                  'assets/goods/ic_cart_quantity_add.png',
                                  color: Colors.pink,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Total: \$${NumberUtil.priceFormat(cartEntity.goodsEntity.price * cartEntity.quantity)}',
                      style: const TextStyle(
                        color: Colors.pink,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _priceBar() {
    return Positioned(
      height: 60,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        color: Colors.white,
        child: Row(
          children: [
            const SizedBox(
              width: 12,
            ),
            Obx(
              () => ImageCheckBox(
                check: CartController.instance.selectAll.value,
                label: const Text(
                  'Select All',
                  style: TextStyle(color: Colors.pink),
                ),
                onChange: (value) => CartController.instance.selectAllChange(),
              ),
            ),
            Expanded(
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _priceItem('Total:', CartController.instance.total.value,
                        size: 10),
                    _priceItem('Discount:', -0000, size: 10),
                    _priceItem('Amount:', CartController.instance.total.value,
                        size: 12, color: Colors.red),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                height: 60,
                width: 120,
                color: Colors.red,
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _priceItem(String label, int price, {double? size, Color? color}) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              label,
              style: TextStyle(color: Colors.black87, fontSize: size ?? 14),
            ),
          ),
        ),
        Expanded(
          child: Text(
            ' \$${NumberUtil.priceFormat(price)}',
            style: TextStyle(
                color: color ?? Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: size ?? 14),
          ),
        ),
      ],
    );
  }

  _deleteItem(BuildContext context, int index) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Warning',
      desc: 'Are you sure you want to remove this item?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        CartController.instance.commodities.removeAt(index);
      },
    ).show();
  }
}

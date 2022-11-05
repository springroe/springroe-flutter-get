import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_get/ui/commodity/controller/commodity_controller.dart';

class CommodityPage extends StatelessWidget {
  const CommodityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: 350,
            child: Image.asset(
              CommodityController.instance.commodity.value.picture,
            ),
          ),
          Positioned(
            left: 10,
            top: 20,
            child: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_ios),
            ),
          )
        ],
      ),
    );
  }
}

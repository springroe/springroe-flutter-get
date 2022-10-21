import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:test_get/model/goods_entity.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  List<GoodsEntity> goods = <GoodsEntity>[].obs;

  var currentPage = 1.obs;

  final List<String> bannerImages = [
    'assets/banner/banner1.webp',
    'assets/banner/banner2.webp',
    'assets/banner/banner3.webp'
  ];

  @override
  onInit() {
    super.onInit();
    fetchData();
  }

  fetchData() async {
    currentPage(1);
    String jsonStr = await rootBundle.loadString('assets/data/goods.json');
    List jsonList = jsonDecode(jsonStr);
    goods.assignAll(jsonList.map((e) {
      var entity = GoodsEntity.fromJson(e);
      entity.id = Random().nextInt(99999999).toString();
      return entity;
    }).toList());
    debugPrint(goods.obs.toString());
  }

  loadMore() async {
    String jsonStr = await rootBundle.loadString('assets/data/goods.json');
    List jsonList = jsonDecode(jsonStr);
    goods.addAll(jsonList.map((e) {
      var entity = GoodsEntity.fromJson(e);
      entity.id = Random().nextInt(99999999).toString();
      return entity;
    }).toList());
    currentPage++;
  }
}

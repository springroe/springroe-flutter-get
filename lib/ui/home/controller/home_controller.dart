import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:test_get/model/goods_entity.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  List<GoodsEntity> goods = <GoodsEntity>[].obs;

  var currentPage = 1.obs;

  final List<String> bannerImages = [
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.tuguaishou.com%2Fips_templ_preview%2F52%2F27%2F12%2Flg_2562207_1572940515_5dc12ae3be156.jpg%21w1024_w%3Fauth_key%3D2208932719-0-0-cead5a8c5873fcc4375956459dce00d9&refer=http%3A%2F%2Fimg.tuguaishou.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1656645916&t=d4a37514f5f2e0a3bbcfa7d2459a6c24',
    'https://img2.baidu.com/it/u=2997969757,3350167107&fm=253&fmt=auto&app=138&f=JPG?w=500&h=250',
    'https://img1.baidu.com/it/u=134931005,623355085&fm=253&fmt=auto&app=138&f=JPG?w=1024&h=499'
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
    goods.assignAll(jsonList.map((e) => GoodsEntity.fromJson(e)).toList());
  }

  loadMore() async {
    String jsonStr = await rootBundle.loadString('assets/data/goods.json');
    List jsonList = jsonDecode(jsonStr);
    goods.addAll(jsonList.map((e) => GoodsEntity.fromJson(e)).toList());
    currentPage++;
  }
}

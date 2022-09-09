import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_get/generated/l10n.dart';
import 'package:test_get/ui/cart/controller/cart_controller.dart';
import 'package:test_get/ui/entrance/controller/login_controller.dart';
import 'package:test_get/ui/home/controller/home_controller.dart';
import 'package:test_get/ui/member/controller/member_controller.dart';
import 'package:test_get/ui/navigator/controller/navigator_controller.dart';
import 'package:test_get/ui/navigator/navigator_page.dart';

void main() {
  runApp(const MyApp());

  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      // 头部触发刷新的越界距离
      headerTriggerDistance: 80.0,
      // 自定义回弹动画,三个属性值意义请查询flutter api
      springDescription:
          const SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
      //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
      maxOverScrollExtent: 100,
      // 底部最大可以拖动的范围
      maxUnderScrollExtent: 100,
      //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
      enableScrollWhenRefreshCompleted: true,
      //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
      enableLoadingWhenFailed: true,
      // Viewport不满一屏时,禁用上拉加载更多功能
      hideFooterWhenNotFull: false,
      // 可以通过惯性滑动触发加载更多
      enableBallisticLoad: true,
      child: GetMaterialApp(
        home: const NavigatorPage(),
        theme: ThemeData(fontFamily: 'Source'),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
      ),
    );
  }
}

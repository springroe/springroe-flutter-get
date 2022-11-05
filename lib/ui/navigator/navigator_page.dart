import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_get/ui/cart/cart_page.dart';
import 'package:test_get/ui/commodity/controller/commodity_controller.dart';
import 'package:test_get/ui/home/home_page.dart';
import 'package:test_get/ui/member/member_page.dart';
import 'package:test_get/ui/navigator/controller/navigator_controller.dart';
import 'package:test_get/widget/navigator/animated_bottom_navigation_bar.dart';

import '../cart/controller/cart_controller.dart';
import '../entrance/controller/login_controller.dart';
import '../home/controller/home_controller.dart';
import '../member/controller/member_controller.dart';

class NavigatorPage extends StatelessWidget {
  const NavigatorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //配置Controller
    Get.put(NaviController());
    Get.put(HomeController());
    Get.put(CartController());
    Get.put(MemberController());
    Get.put(LoginController());
    Get.put(CommodityController());

    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: NaviController.instance.index.value,
          children: [HomePage(), const CartPage(), const MemberPage()],
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
            itemCount: NaviController.instance.tabItems.length,
            tabBuilder: (int index, bool isActive) =>
                _naviItem(index, isActive),
            activeIndex: NaviController.instance.index.value,
            elevation: 2,
            backgroundColor: Colors.white,
            notchSmoothness: NotchSmoothness.sharpEdge,
            gapLocation: GapLocation.none,
            onTap: (index) {
              NaviController.instance.index(index);
            }),
      ),
    );
  }

  Column _naviItem(int index, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          NaviController.instance.tabItems[index].icon,
          width: 24,
          height: 24,
          color: isActive ? Colors.blue : Colors.grey[300],
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          NaviController.instance.tabItems[index].name,
          style: TextStyle(
              fontSize: 11, color: isActive ? Colors.lightBlue : Colors.grey),
        )
      ],
    );
  }
}

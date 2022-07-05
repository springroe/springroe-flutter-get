import 'package:get/get.dart';
import 'package:test_get/generated/l10n.dart';
import 'package:test_get/ui/cart/cart_page.dart';
import 'package:test_get/ui/home/home_page.dart';
import 'package:test_get/ui/member/member_page.dart';
import 'package:test_get/ui/navigator/model/tab_item.dart';

class NaviController extends GetxController {
  static NaviController get instance => Get.find();

  final tabItems = <TabItem>[
    TabItem('assets/navigator/ic_navi_home.png', S.current.naviHome),
    TabItem('assets/navigator/ic_navi_cart.png', S.current.naviCart),
    TabItem('assets/navigator/ic_navi_member.png', S.current.naviMember),
  ];

  var index = 0.obs;
}

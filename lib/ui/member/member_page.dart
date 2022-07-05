import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_get/ui/entrance/login_page.dart';
import 'package:test_get/ui/member/controller/member_controller.dart';

class MemberPage extends StatelessWidget {
  const MemberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          top: 100,
          child: ValueBuilder(
              initialValue: MemberController.instance.user,
              builder: (value, user) {
                // TODO - 考虑下没有用户的时候是登录，登录后显示用户头像
                return GestureDetector(
                  onTap: () => Get.to(const LoginPage()),
                  child: const SizedBox(
                    height: 100,
                    width: 100,
                    child: CircleAvatar(
                      foregroundColor: Colors.pink,
                      child: Text('Login'),
                    ),
                  ),
                );
              }),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 240,
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                  ),
                  child: Column(
                    children: [
                      _menu(
                          'Order', 'assets/goods/ic_goods_discount.png', () {}),
                      _divider(),
                      _menu('History', 'assets/goods/ic_goods_boutique.png',
                          () {}),
                      _divider(),
                      _menu('Collect', 'assets/goods/ic_goods_preference.png',
                          () {}),
                      _divider(),
                      _menu('About', 'assets/goods/ic_goods_import.png', () {}),
                    ],
                  )),
              _logout(context)
            ],
          ),
        ),
      ],
    );
  }

  Divider _divider() {
    return const Divider(
      height: 0,
    );
  }

  Widget _menu(String title, String asset, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 70,
        child: Row(
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: Image.asset(asset),
            ),
            const Padding(padding: EdgeInsets.only(left: 10)),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.pink,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _logout(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.WARNING,
          animType: AnimType.SCALE,
          keyboardAware: false,
          title: 'Ohh!',
          desc: 'Do you want to leave me?',
          btnCancelText: 'No',
          btnCancelOnPress: () {},
          btnOkText: 'Aye',
          btnOkOnPress: () {
            Get.to(const LoginPage());
          },
        ).show();
      },
      child: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: const Center(
          child: Text(
            'Logout',
            style: TextStyle(
                color: Colors.pink, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

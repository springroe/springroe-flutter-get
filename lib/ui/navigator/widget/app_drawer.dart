import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_get/ui/entrance/login_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: const CircleAvatar(
              child: Text('J'),
            ),
            title: const Text(
              'Jane',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            subtitle: Text(
              'do not touch me!',
              style: TextStyle(
                  color: Colors.grey[400], fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Get.off(const LoginPage());
            },
          ),
          _item('Order'),
          _item('Wallet'),
          _item('Collect'),
          _item('History'),
          _item('Help'),
          _item('About')
        ],
      ),
    );
  }

  ListTile _item(String label) {
    return ListTile(
      title: Text(
        label,
        style: const TextStyle(
            color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      trailing: const Icon(
        CupertinoIcons.forward,
        color: Colors.blue,
      ),
    );
  }
}

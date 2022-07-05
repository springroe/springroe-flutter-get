import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_get/ui/entrance/controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    Get.put(LoginController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [_header(), _form()],
        ),
      ),
    );
  }

  Stack _header() {
    return Stack(
      children: [
        Positioned(
          child: Image.asset('assets/login/login_bg.png'),
        ),
        const Positioned(
          top: 100,
          left: 20,
          child: Text(
            'Welcome back',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Form _form() {
    var formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(hintText: 'account'),
              onSaved: (value) {
                if (value != null) {
                  LoginController.instance.account = value;
                }
              },
              validator: (value) {
                return LoginController.instance.checkAccount(value);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'password'),
              obscureText: true,
              onSaved: (value) {
                if (value != null) {
                  LoginController.instance.password = value;
                }
              },
              validator: (value) {
                return LoginController.instance.checkPassword(value);
              },
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                child: const Text(
                  'Login in',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                onPressed: () {
                  var state = formKey.currentState;
                  if (state != null) {
                    if (state.validate()) {
                      state.save();
                      LoginController.instance.login();
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

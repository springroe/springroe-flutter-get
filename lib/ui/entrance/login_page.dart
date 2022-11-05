import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:test_get/ui/entrance/controller/login_controller.dart';
import 'package:test_get/ui/entrance/login_clipper.dart';
import 'package:test_get/ui/navigator/navigator_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [_header(), _form(context)],
        ),
      ),
    );
  }

  Stack _header() {
    return Stack(
      children: [
        Positioned(
          child: ClipPath(
            clipper: LoginClipper(),
            child: Container(
              color: Colors.blue,
              height: 200,
            ),
          ),
        ),
        const Positioned(
          top: 100,
          left: 20,
          child: Text(
            'Welcome!',
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

  Form _form(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'input email or mobile',
                label: Text('account'),
              ),
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
              decoration: const InputDecoration(
                  hintText: 'input password', label: Text('password')),
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
              height: 44,
              child: ElevatedButton(
                child: const Text(
                  'Login in',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                onPressed: () {
                  var state = formKey.currentState;
                  if (state != null) {
                    if (state.validate()) {
                      state.save();

                      EasyLoading.show(
                          status: 'loading...',
                          maskType: EasyLoadingMaskType.black);

                      LoginController.instance.login().then((exception) {
                        EasyLoading.dismiss();
                        if (exception == null) {
                          Get.off(const NavigatorPage());
                        } else {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            headerAnimationLoop: false,
                            title: 'Error',
                            desc: exception.toString(),
                            btnOkOnPress: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            btnOkIcon: Icons.cancel,
                            btnOkColor: Colors.red,
                          ).show();
                        }
                      });
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

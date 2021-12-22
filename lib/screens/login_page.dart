import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:h_art/controller/auth_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController ac = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // Image.asset("assets/2.0x/diamond.png",
          //     width: 100, height: 100, color: Colors.black),
          Column(
            children: [
              SizedBox(
                width: 280,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red.shade200,
                  ),
                  child: const Text(
                    'Sign in with Google',
                    style: TextStyle(fontSize: 17),
                  ),
                  onPressed: ac.signInGoogle,
                ),
              ),
              const SizedBox(
                height: 150,
              ),
              // SizedBox(
              //   width: 280,
              //   height: 50,
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       primary: Colors.grey.shade500,
              //     ),
              //     child: const Text(
              //       'Guest Login',
              //       style: TextStyle(fontSize: 17),
              //     ),
              //     onPressed: ac.signInAnon,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    ));
  }
}

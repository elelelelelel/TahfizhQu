import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tahfizh_qu_app/features/hafalan_feature/pages/login/controller_login.dart';

class PageLogin extends GetView<ControllrerLogin> {
  PageLogin({Key? key}) : super(key: key);
  final myC = Get.put(ControllrerLogin());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          color: Color(0xff38A169),
        ),
        Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              "assets/assets/pola.png",
              opacity: const AlwaysStoppedAnimation(.3),
            )),
        Positioned(
            top: 50,
            left: 120,
            child: Image.asset(
              "assets/assets/pola.png",
              opacity: const AlwaysStoppedAnimation(.3),
            )),
        Positioned(
          top: 40,
          left: 120,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Image.asset("assets/assets/TahfizhQu.png"),
              ),
            ),
          ),
        ),
        const Positioned(
          top: 100,
          left: 100,
          child: Text(
            "Menghafal dalam genggaman",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        Positioned(
          bottom: 10,
          child: Container(
            height: MediaQuery.of(context).size.height / 1.3,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/assets/login_huruf.png"),
                ),
                SizedBox(
                  height: 20,
                ),
                Lottie.asset("assets/assets/lottie/login_ilustrasi.json"),
                // Obx(
                //   () => myC.isLoading.value == true
                //       ? Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: CircularProgressIndicator(
                //             color: Color(0xff38A169),
                //           ),
                //         )
                SignInButton(
                  Buttons.Google,
                  text: "Masuk Dengan Google",
                  onPressed: () {
                    controller.loginWithGoogle();
                    // Get.toNamed('home_screen');
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    ))));
  }
}

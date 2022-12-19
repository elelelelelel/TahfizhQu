import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tahfizh_qu_app/features/hafalan_feature/pages/login/page_login.dart';
import 'package:tahfizh_qu_app/utils/routes/routes_names.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      // Navigator.pushReplacementNamed(context, RoutesNames.login);
      Get.to(PageLogin());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Splash_Screen.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home/homeC.dart';

class DetailPage extends StatelessWidget {
  DetailPage({Key? key, required this.text}) : super(key: key);
  final myC = Get.find<HomeController>();

  String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(text),
          );
        },
      ),
    );
  }
}

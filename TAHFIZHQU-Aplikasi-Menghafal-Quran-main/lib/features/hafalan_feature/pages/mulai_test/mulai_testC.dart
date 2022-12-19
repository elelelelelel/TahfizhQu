import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:tahfizh_qu_app/features/hafalan_feature/pages/hasil_test/hasil_test.dart';

import '../home/homeC.dart';

class MulaiTestController extends GetxController {
  final myC = Get.find<HomeController>();
  RxInt timeleft = 60.obs;
  RxInt petunjuk = 3.obs;
  RxInt soal = 1.obs;
  RxInt nilaiTest = 0.obs;
  RxInt jawabanBenar = 0.obs;
  RxInt jawabanSalah = 0.obs;
  RxBool jawaban = false.obs;
  RxBool sudahJawaban = false.obs;
  RxBool showpetunjuk = false.obs;
  RxBool hasilJawaban = false.obs;
  RxBool showJawaban = false.obs;
  RxBool showPlayRecord = false.obs;

  final StopWatchTimer stopWatchTimer = StopWatchTimer();
  final isHours = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    stopWatchTimer.dispose();
  }

  void playerRecorder() {
    showPlayRecord.value = true;
  }

  void hasilJawabanvalu() {
    hasilJawaban.value = true;
  }

  void tampilJawaban() {
    showJawaban.value = true;
  }

  void periksaJawaban() {
    jawaban.value = true;
  }

  void jumlahJawabanBenar() {
    jawabanBenar++;
  }

  void resetJawabanBenar() {
    jawabanBenar.value = 0;
    jawabanSalah.value = 0;
    nilaiTest.value = 0;
  }

  void jumlahJawabanSalah() {
    jawabanSalah++;
  }

  void tampilkanpetunjuk() {
    showpetunjuk.value = true;
  }

  void tambahNilai() {
    nilaiTest + 10;
  }

  void resultTest(int jawabanBenar) {
    var resultTess =
        jawabanBenar * 10 / Get.find<HomeController>().counterTest.value;
    nilaiTest.value = int.parse(resultTess.toStringAsFixed(0));
    print("cek : " + resultTess.toString());

    Get.to(HasilTestPage());
  }

  void starCount() async {
    print("masuk");
    Timer.periodic(Duration(seconds: 1), (timer) {
      print("masuk w");

      if (timeleft > 0) {
        // timeleft--;
        if (timeleft == 0) {
          Get.defaultDialog(
              middleText: "Soal Selanjutnya",
              title: "Waktu Habis",
              barrierDismissible: false,
              // middleText: "Klik ke soal selanjutnya",
              actions: [
                InkWell(
                  onTap: () {
                    // if (soal == myC.choiceSurah.length - 1) {
                    //   timeleft.value = 0;
                    // } else {
                    //   timeleft.value = 3;
                    // }
                    // soal++;
                    // Get.back();
                    // starCount();
                    // if (jawaban.isTrue) {
                    //   jawaban.value = false;
                    // }
                    // jumlahJawabanSalah();
                    // showJawaban.value = false;
                    // hasilJawaban.value = false;

                    // periksaJawaban();
                  },
                  child: Column(children: [
                    Image.asset('assets/next 1.png'),
                  ]),
                )
              ]);
        }
      } else {
        timer.cancel();
      }
    });
  }

  void bukaPetunjuk() {
    if (petunjuk > 0) {
      petunjuk--;
    }
    if (petunjuk == 0) {
      Text('Petunjuk Habis');
    } else {}
  }

  //Soal

  void soalSelanjutnya() {
    soal++;
  }

  void soalSebelumnya() {
    soal--;
  }
}

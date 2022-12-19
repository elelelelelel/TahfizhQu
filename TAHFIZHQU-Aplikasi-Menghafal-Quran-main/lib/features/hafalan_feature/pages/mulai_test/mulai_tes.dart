import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:tahfizh_qu_app/features/hafalan_feature/pages/home/homeC.dart';
import 'package:tahfizh_qu_app/features/hafalan_feature/pages/mulai_test/mulai_testC.dart';
import 'package:tahfizh_qu_app/features/hafalan_feature/pages/mulai_test/soundrecord.dart';
import 'package:tahfizh_qu_app/theme.dart';

import '../hasil_test/hasil_test.dart';
import '../home/homepage.dart';

class MulaiTest extends StatefulWidget {
  @override
  State<MulaiTest> createState() => _MulaiTestState();
}

class _MulaiTestState extends State<MulaiTest> {
  final myC = Get.put(MulaiTestController());
  final myHomeC = Get.find<HomeController>(); final player1 = SoundPlayer();
  final _random = Random();

  @override
  void initState() {
    initRecorder();
    super.initState();
    player1.init();
  }

  @override
  void dispose() {
    player1.dispose();
    recorder.closeRecorder();
    super.dispose();
  }

  final recorder = FlutterSoundRecorder();

  //Microphone access

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw "Permission not granded";
    }
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future startRecord() async {
    await recorder.startRecorder(toFile: 'audio');
  }

  Future stopRecord() async {
    final filePath = await recorder.stopRecorder();
    final file = File(filePath!);
    print('Recorded file path: $filePath');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Mulai Test',
          style: greenTextStyle.copyWith(),
        ),
        actions: [
          Image.asset("assets/assets/All icon1.png"),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.list,
                color: greenC,
              ))
        ],
        leading: IconButton(
            onPressed: () {
              Get.off(HomePage());
              // Navigator.pop(context);
              // myC.timeleft.close();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: greenC,
            )),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 71,
                    decoration: BoxDecoration(
                        color: greenC, borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Soal',
                              style: TextStyle(color: Colors.white),
                            ),
                            Obx(() => Text(
                                  '${myC.soal}/${myHomeC.counterTest.value}',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ],
                        ),
                        Container(
                          width: 1,
                          height: 50,
                          color: Colors.white,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Waktu',
                              style: TextStyle(color: Colors.white),
                            ),
                            StopWatch(
                              myC: myC,
                              color: Colors.white,
                            )
                          ],
                        ),
                        Container(
                          width: 1,
                          height: 50,
                          color: Colors.white,
                        ),
                        InkWell(
                          onTap: () {
                            if (myC.petunjuk.value == 0) {
                              Get.defaultDialog(title: "Petunjuk Habis");
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    actionsPadding: EdgeInsets.only(bottom: 30),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    title: Text(
                                      'Gunakan Petunjuk?',
                                      style: TextStyle(color: greenC),
                                    ),
                                    actions: [
                                      Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 80,
                                              height: 26,
                                              decoration: const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey,
                                                        blurRadius: 4,
                                                        offset: Offset(0, 5))
                                                  ]),
                                              child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor: greenC,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Tidak")),
                                            ),
                                            Container(
                                              decoration: const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey,
                                                        blurRadius: 2,
                                                        offset: Offset(0, 5))
                                                  ]),
                                              width: 80,
                                              height: 26,
                                              child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor: greenC,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                  onPressed: () {
                                                    myC.bukaPetunjuk();
                                                    Get.back();
                                                    // myC.bukaPetunjuk();
                                                    myC.tampilkanpetunjuk();
                                                  },
                                                  child: Text("Ya")),
                                            )
                                          ],
                                        ),
                                      )
                                    ],

                                    // content: Column(
                                    //   children: [

                                    //   ],
                                  );
                                },
                              );
                            }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Obx(
                                    () => Text(
                                      '${myC.petunjuk}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Image.asset('assets/assets/idea 1.png')
                                ],
                              ),
                              const Text(
                                'Petunjuk',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Soal tes",
                    style: TextStyle(
                        fontSize: 16, fontWeight: medium, color: greenC),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerRight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: greenC, borderRadius: BorderRadius.circular(10)),
                    child: Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              myHomeC.tampunganSurah[myC.soal.value - 1],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: bold,
                                  fontSize: 16),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 23,
                  ),
                  Text(
                    "Rekam Jawaban",
                    style: TextStyle(
                        fontSize: 16, fontWeight: medium, color: greenC),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20),
                    alignment: Alignment.centerRight,
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey[400]!)
                        // boxShadow: [
                        //   BoxShadow(
                        //       color: Colors.grey, blurRadius: 5, spreadRadius: 1)
                        // ]
                        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        StreamBuilder<RecordingDisposition>(
                            builder: (context, snapshot) {
                              final duration = snapshot.hasData
                                  ? snapshot.data!.duration
                                  : Duration.zero;

                              String twoDigits(int n) =>
                                  n.toString().padLeft(2, "0");
                              final twoDigitsMinuts =
                                  twoDigits(duration.inMinutes.remainder(60));
                              final twoDigitsSeconds =
                                  twoDigits(duration.inSeconds.remainder(60));
                              return Text("$twoDigitsMinuts:$twoDigitsSeconds");
                            },
                            stream: recorder.onProgress),
                        myC.showPlayRecord.isTrue ? buildPlay() : SizedBox(),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            onTap: () async {
                              if (recorder.isRecording) {
                                await stopRecord();
                                myC.playerRecorder();

                                setState(() {});
                              } else {
                                await startRecord();
                                setState(() {});
                              }
                            },
                            child: recorder.isRecording
                                ? Icon(
                                    Icons.stop,
                                    color: Colors.red,
                                  )
                                : Image.asset('assets/assets/Group.png')),
                      ],
                    ),
                  ),
                  Obx(
                    () => Column(
                      children: [
                        myC.showJawaban.isFalse
                            ? SizedBox()
                            : Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Jawaban",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: medium,
                                          color: greenC),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.centerRight,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: greenC,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Obx(() => Text(
                                            myHomeC.tampunganJawaban[
                                                myC.soal.value - 1],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: bold,
                                                fontSize: 16),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                  Obx(
                    () => Column(
                      children: [
                        myC.showpetunjuk.isFalse
                            ? SizedBox()
                            : Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Petunjuk Jawaban",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: medium,
                                          color: greenC),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.centerRight,
                                      width: double.infinity,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          color: greenC,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Obx(() => Text(
                                            '${myHomeC.tampunganJawaban[
                                                myC.soal.value - 1]}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: bold,
                                                fontSize: 16),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Obx(
                    () => Center(
                        child: myC.jawaban.isFalse
                            ? Column(
                                children: [
                                  Text(
                                    'Sudah yakin dengan jawaban Anda?',
                                    style: TextStyle(color: greenC),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      myC.periksaJawaban();
                                      myC.tampilJawaban();
                                      myC.sudahJawaban.value = false;
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 131,
                                      height: 24,
                                      decoration: BoxDecoration(
                                          color: greenC,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        'Periksa Jawaban',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : myC.hasilJawaban.isFalse
                                ? myC.sudahJawaban.value == false
                                    ? Column(
                                        children: [
                                          Text(
                                            'Apakah jawaban Anda benar?',
                                            style: TextStyle(color: greenC),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    myC.sudahJawaban.value =
                                                        true;
                                                    myC.jawabanSalah.value =
                                                        myC.jawabanSalah.value +
                                                            1;
                                                    // myC.hasilJawabanvalu();
                                                    // myC.jumlahJawabanSalah();
                                                    // myC.periksaJawaban();
                                                    // myC.jawaban.toggle();
                                                  },
                                                  child: Image.asset(
                                                    'assets/assets/cancel 1.png',
                                                    width: 50,
                                                    height: 50,
                                                  )),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  myC.sudahJawaban.value = true;
                                                  myC.jawabanBenar.value =
                                                      myC.jawabanBenar.value +
                                                          1;
                                                  // myC.hasilJawabanvalu();
                                                  // myC.jumlahJawabanBenar();
                                                  // myC.tambahNilai();
                                                },
                                                child: Image.asset(
                                                  'assets/assets/checked 1.png',
                                                  width: 50,
                                                  height: 50,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    : SizedBox()
                                : Text('Terima Kasih')),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => myC.soal == 1
                          ? SizedBox()
                          : Column(
                              children: [
                                Text(
                                  'Soal',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: medium,
                                      color: greenC),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                    onTap: () {
                                      myC.periksaJawaban();
                                      myC.hasilJawabanvalu();

                                      myC.hasilJawaban.value == false;
                                      myC.soalSebelumnya();
                                    },
                                    child: Image.asset(
                                        'assets/assets/next 2.png')),
                                SizedBox(
                                  height: 16,
                                ),
                                Text('Sebelumnya',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: medium,
                                        color: greenC)),
                              ],
                            ),
                    ),
                    Obx(() => myHomeC.counterTest.value == 1 || myC.soal == myHomeC.counterTest.value
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                InkWell(
                                  onTap: () {
                                    if (myC.sudahJawaban.isTrue) {
                                      myC.stopWatchTimer.onStopTimer();
                                      myC.resultTest(myC.jawabanBenar.value);
                                    } else {
                                      final snackBar = SnackBar(
                                        content: const Text(
                                            'Silakan periksa jawaban terlebih dahulu !'),
                                        backgroundColor: (Colors.red),
                                        action: SnackBarAction(
                                          label: '',
                                          onPressed: () {},
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  },
                                  child: Container(
                                      margin:
                                          EdgeInsets.only(right: 20, top: 20),
                                      padding:
                                          EdgeInsets.only(top: 5, right: 5),
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: greenC,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Image.asset(
                                          'assets/assets/send (2) 1.png')),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Text('Selesai',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: medium,
                                        color: greenC))
                              ])
                        : Column(children: [
                            Text(
                              'Soal',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: medium,
                                  color: greenC),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                                onTap: () {
                                  if ( myC.sudahJawaban.isTrue ) {
                                          myC.soalSelanjutnya();
                                          if (myC.jawaban.isTrue) {
                                    myC.jawaban.value = false;
                                  }
                                  myC.hasilJawaban.value = false;
                                  myC.showpetunjuk.value = false;
                                  myC.showJawaban.value = false;
                                  myC.sudahJawaban.value = false;
                                          // myC.jawabanBenar.close();
                                    } else {
                                      final snackBar = SnackBar(
                                        content: const Text(
                                            'Silakan periksa jawaban terlebih dahulu !'),
                                        backgroundColor: (Colors.red),
                                        action: SnackBarAction(
                                          label: '',
                                          onPressed: () {},
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  // myC.soalSelanjutnya();
                                  // if (myC.soal == 9) {
                                  //   myC.timeleft.value = 0;
                                  // } else {
                                  //   myC.timeleft.value = 3;
                                  // }
                                  // myC.timeleft.value = 3;
                                  // if (myC.jawaban.isTrue) {
                                  //   myC.jawaban.value = false;
                                  // }
                                  // myC.hasilJawaban.value = false;
                                  // myC.showpetunjuk.value = false;
                                  // myC.showJawaban.value = false;
                                  // myC.jawabanBenar.value == 0;
                                  // myC.jawabanSalah.value == 0;

                                },
                                child: Image.asset('assets/assets/next 1.png')),
                            SizedBox(
                              height: 16,
                            ),
                            Text('Selanjutnya',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: medium,
                                    color: greenC))
                          ]))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPlay() {
    final isPlaying = player1.isPlaying;
    final icon = isPlaying ? Icons.stop : Icons.play_arrow;
    final color = isPlaying ? Colors.red : greenC;

    return IconButton(
        onPressed: () async {
          await player1.tooglePlaying(whenFinished: () => setState(() {}));
          setState(() {});
        },
        icon: Icon(
          icon,
          color: color,
        ));
  }
}

class StopWatch extends StatelessWidget {
  StopWatch({
    Key? key,
    required this.color,
    required this.myC,
  }) : super(key: key);

  final MulaiTestController myC;
  Color color;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: myC.stopWatchTimer.rawTime,
      initialData: myC.stopWatchTimer.rawTime.value,
      builder: (context, snapshot) {
        final value = snapshot.data;
        final displayTime =
            StopWatchTimer.getDisplayTime(value!, hours: myC.isHours);
        return Text(displayTime, style: TextStyle(color: color));
      },
    );
  }
}

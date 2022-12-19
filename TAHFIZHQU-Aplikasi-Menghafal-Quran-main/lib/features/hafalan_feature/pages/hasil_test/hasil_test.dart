import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tahfizh_qu_app/features/hafalan_feature/pages/home/homeC.dart';
import 'package:tahfizh_qu_app/features/hafalan_feature/pages/mulai_test/mulai_tes.dart';
import 'package:tahfizh_qu_app/features/hafalan_feature/pages/mulai_test/mulai_testC.dart';
import 'package:tahfizh_qu_app/theme.dart';

import '../home/homepage.dart';

class HasilTestPage extends StatelessWidget {
  //  HasilTestPage({super.key});
  final myC = Get.find<MulaiTestController>();
  final myHomeC = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Hasil Tes',
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
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: greenC,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(24),
                  height: 154,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: greenC,
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/assets/unsplash_svnLIZ6jgCQ.png'),
                          fit: BoxFit.cover)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/assets/All icon.png'),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Motivasi',
                            style: TextStyle(
                                color: Colors.white, fontWeight: semiBold),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Sebaik - baik manusia diantara kamu adalah yang mempelajari Al-Quran dan mengajarkannya (HR Bukhori)',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: Image.asset('assets/assets/petik.png'))
              ],
            ),
            SizedBox(
              height: 47,
            ),
            Column(
              children: [
                Container(
                  height: 290,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey, blurRadius: 5, spreadRadius: 1)
                      ]),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 95,
                        decoration: BoxDecoration(
                            color: greenC,
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('assets/assets/dialog.png'),
                              Image.asset('assets/assets/Group 101.png'),
                              Image.asset('assets/assets/dialog2.png'),
                            ]),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              padding: EdgeInsets.only(left: 17),
                              // alignment: Alignment.center,

                              width: 90,
                              child: Text("Waktu")),
                          Container(
                              width: 18,
                              child: Image.asset("assets/assets/queue 1.png")),
                          Container(
                              alignment: Alignment.center,
                              child: StopWatch(
                                myC: myC,
                                color: Colors.black,
                              ))
                          // Text(hasil)
                        ],
                      ),
                      HasilTest(
                          hasil: "${myC.jawabanBenar.value}",
                          imageUrl: "assets/assets/checked 2.png",
                          title: "Benar"),
                      HasilTest(
                          hasil: "${myC.jawabanSalah.value}",
                          imageUrl: "assets/assets/cancel 2.png",
                          title: "Salah"),
                      HasilTest(
                          hasil: myC.nilaiTest.value.toString(),
                          imageUrl: "assets/assets/success 1.png",
                          title: "Sekor"),
                      SizedBox(
                        height: 34,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 120,
                            height: 35,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: greenC,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Image.asset('assets/assets/review 1.png'),
                                    Text(
                                      'Tinjauan',
                                      style: TextStyle(fontWeight: semiBold),
                                    )
                                  ],
                                )),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 120,
                            height: 35,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: greenC,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                onPressed: () {
                                  myC.resetJawabanBenar();
                                  Get.off(HomePage());
                                  myHomeC.jumlahTes.value = 0;
                                  myC.stopWatchTimer.onResetTimer();
                                },
                                child: Row(
                                  children: [
                                    Image.asset('assets/assets/Vector.png'),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Kembali',
                                      style: TextStyle(fontWeight: semiBold),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HasilTest extends StatelessWidget {
  const HasilTest({
    Key? key,
    required this.hasil,
    required this.imageUrl,
    required this.title,
  }) : super(key: key);

  final String title;
  final String imageUrl;
  final String hasil;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(width: 57, child: Text(title)),
        Container(width: 18, child: Image.asset(imageUrl)),
        Container(alignment: Alignment.center, width: 39, child: Text(hasil))
        // Text(hasil)
      ],
    );
  }
}

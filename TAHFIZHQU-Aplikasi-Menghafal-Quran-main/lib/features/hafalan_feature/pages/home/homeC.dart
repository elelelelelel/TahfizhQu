import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:tahfizh_qu_app/features/hafalan_feature/pages/mulai_test/mulai_tes.dart';
import 'package:tahfizh_qu_app/features/hafalan_feature/pages/mulai_test/mulai_testC.dart';

class HomeController extends GetxController {
  RxInt tambahTes = 0.obs;
  RxBool addTest = false.obs;
  RxList allSurah = [].obs;
  RxList idx = [].obs;
  RxInt number = 0.obs;
  RxList allJuzz = [].obs;
  List testSearch = [];
  RxList searchList = [].obs;
  RxList moreAnswer = [].obs;
  RxList searchListJuzz = [].obs;
  RxList choiceSurah = [].obs;
  RxList choiceJuzz = [].obs;
  RxInt currentTab = 0.obs;
  RxInt jumlahTes = 0.obs;
  RxBool tesDipilih = false.obs;
  RxBool load = false.obs;
  RxInt plus = 1.obs;
  RxInt counterTest = 0.obs;
  RxInt lenghtAyahsCustom = 0.obs;

  RxList suratCustum = [].obs;

  RxList tampunganSurah = [].obs;
  RxList tampunganSurahEnglishName = [].obs;
  RxList tampunganJawaban = [].obs;

  RxList tampunganNamaTest = [].obs;
  RxList tampunganAyatDari = [].obs;
  RxList tampunganSamapaiAyat = [].obs;

  RxList customDataList = [].obs;

  RxString nameSurahs = "".obs;

  TextEditingController namaTestC = TextEditingController();
  TextEditingController ayatDariC = TextEditingController();
  TextEditingController sampaiAyatC = TextEditingController();

  @override
  void onInit() {
    // getAllNotes();
    quranSurah();
    quranJuzz();
    super.onInit();
  }

  RxList<dynamic> dataCount = [].obs;
  RxList<dynamic> dataCountSearch = [].obs;
  RxList<dynamic> dataCountJuzz = [].obs;
  int lengthSurah = 0;

  void searhcValidate(String textSearch) async {
    searchList.clear();
    dataCountSearch.clear();
    if (textSearch.isNotEmpty) {
      allSurah.forEach((element) {
        if (element['englishName']
                .toString()
                .toLowerCase()
                .contains(textSearch) ||
            element['englishName']
                .toString()
                .toUpperCase()
                .contains(textSearch)) {
          searchList.add(element);
          dataCountSearch.clear();

          for (var i in searchList) {
            dataCountSearch.add({"index": i['number'], "value": false});
            print("gada : " + dataCountSearch.length.toString());
          }
        } else {}
      });
    } else {
      quranSurah();
      searchList.clear();
    }
  }

  void searhcValidateJuzz(String textSearch) async {
    searchListJuzz.clear();
    if (textSearch.isNotEmpty) {
      allSurah.value.forEach((element) {
        if (element['englishName']
                .toString()
                .toLowerCase()
                .contains(textSearch) ||
            element['englishName']
                .toString()
                .toUpperCase()
                .contains(textSearch)) {
          searchListJuzz.add(element);
        } else {
          print("gada : ".toString());
        }
      });
    } else {
      quranSurah();
      searchListJuzz.clear();
    }
  }

  void tesSelected() {
    tesDipilih.value = true;
  }

  void increment() {
    jumlahTes++;
  }

  void decrement() {
    jumlahTes--;
  }

  void tab() {
    currentTab++;
  }

  counter(indexs, surah) async {
    load(true);
    for (var i = 0; i < dataCount.length; i++) {
      choiceSurah.clear();
      if (dataCount[i]['index'] == indexs) {
        dataCount[i]['value'] = true.obs;
        choiceSurah.add(surah);
        counterTest.value = counterTest.value + choiceSurah.length;
        load(false);

        print("masuk");
      }
    }
  }

  counterMin(indexs, surah) async {
    load(true);
    choiceSurah.clear();
    for (var i = 0; i < dataCount.length; i++) {
      if (dataCount[i]['index'] == indexs) {
        dataCount[i]['value'] = false.obs;

        // counterTest.value = counterTest.value - choiceSurah.length;
        load(false);

        print("masuk");
      }
    }
  }

  counterSearch(indexs, surah) async {
    load(true);
    print("cek idx  :" + indexs.toString());

    choiceSurah.add(surah);
    print("cek s : " + choiceSurah.length.toString());

    for (var i = 0; i < dataCountSearch.length; i++) {
      if (dataCountSearch[i]['index'] == indexs) {
        dataCountSearch[i]['value'] = true.obs;
        load(false);

        print("masuk");
      }
    }
  }

  counterMinSearch(indexs, surah) async {
    load(true);
    for (var i = 0; i < dataCountSearch.length; i++) {
      if (dataCountSearch[i]['index'] == indexs) {
        dataCountSearch[i]['value'] = false.obs;
        choiceSurah.removeWhere((element) => element['index'] == indexs);
        // counterTest.value = counterTest.value + choiceSurah.length;
        load(false);

        print("masuk");
      }
    }
  }

  counterjuzz(indexs, juzz) async {
    load(true);
    for (var i = 0; i < dataCountJuzz.length; i++) {
      if (dataCountJuzz[i]['index'] == indexs) {
        dataCountJuzz[i]['value'] = true.obs;
        idx.add(dataCountJuzz[i]['index']);
        // getDetailJuz(juzNumber: )
        // choiceJuzz.add(juzz);

        load(false);
      }
    }
  }

  counterMinjuzz(indexs, juzz) async {
    load(true);
    for (var i = 0; i < dataCountJuzz.length; i++) {
      if (dataCountJuzz[i]['index'] == indexs) {
        dataCountJuzz[i]['value'] = false.obs;
        print("Cek " + idx.toString());
        idx.removeWhere((element) => element == indexs);

        load(false);

        print("masuk");
      }
    }
  }

  Future quranSurah() async {
    try {
      final respon = await http.get(
        Uri.parse('http://api.alquran.cloud/v1/quran/quran-uthmani'),
      );
      print(respon.statusCode);

      var data = json.decode(respon.body);

      allSurah.value = json.decode(respon.body)['data']['surahs'];
      for (var i in allSurah) {
        dataCount.add({"index": i['number'], "value": false});
      }
      print(allSurah);
    } catch (err) {
      print(err.toString());
    }
  }

  Future quranJuzz() async {
    try {
      final respon = await http.get(
        Uri.parse('https://api.quran.com/api/v4/juzs'),
      );
      print(respon.statusCode);

      var data = json.decode(respon.body);

      allJuzz.value = json.decode(respon.body)['juzs'];
      for (var i in allJuzz) {
        dataCountJuzz.add({"index": i['juz_number'], "value": false});
      }
      print(allJuzz);
    } catch (err) {
      print(err.toString());
    }
  }

  Future getDetailJuz({required String juzNumber}) async {
    try {
      final mulaiTestC = Get.put(MulaiTestController());

      final respon = await http.get(
        Uri.parse(
            'https://api.quran.com/api/v4/quran/verses/uthmani?juz_number=$juzNumber'),
      );

      var data = json.decode(respon.body)['verses'];
      final numberRandom = Random().nextInt(data.length);
      // for (var i in data) {
      tampunganSurah.add(data[numberRandom]['text_uthmani']);
      tampunganJawaban.add(data[numberRandom + 1]['text_uthmani']);
      // for (var i in data) {
      //   moreAnswer.add(i['text_uthmani']);
      // }
      mulaiTestC.starCount();
      mulaiTestC.timeleft.value = 3;
      mulaiTestC.soal.value = 1;
      // mulaiTestC.hasilJawaban.value = false;
      Get.to(() => MulaiTest());

      // }

      // allJuzz.value = json.decode(respon.body)['juzs'];
      // for (var i in allJuzz) {
      //   dataCountJuzz.value.add({"index": i['number'], "value": false});
      // }
      // print(allJuzz);
    } catch (err) {
      print(err.toString());
    }
  }

  // Future quranJuzz() async {
  //   try {
  //     var response = await http
  //         .get(Uri.parse('http://api.alquran.cloud/v1/juz/30/quran-uthmani'));
  //     List data =
  //         (json.decode(response.body) as Map<String, dynamic>)["data"]['ayahs'];
  //     data.forEach((element) {
  //       allJuzz.add(element);
  //     });
  //     print(allJuzz.toString());
  //   } catch (e) {}
  // }

  void tambah() {}
}

import 'dart:math';

import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tahfizh_qu_app/features/hafalan_feature/pages/home/homeC.dart';
import 'package:tahfizh_qu_app/features/hafalan_feature/pages/mulai_test/mulai_tes.dart';
import 'package:tahfizh_qu_app/features/hafalan_feature/pages/mulai_test/mulai_testC.dart';
import 'package:tahfizh_qu_app/theme.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myC = Get.put(HomeController());
  final mulaiTestC = Get.put(MulaiTestController());
  String nameSurahCustom = "";

  void _actionMulai() {
    if (myC.currentTab.value == 0) {
      if (myC.counterTest.value == 0) {
        final snackBar = SnackBar(
          content: const Text('Silakan tambahkan Surah terlebih dahulu !'),
          backgroundColor: (Colors.red),
          action: SnackBarAction(
            label: '',
            onPressed: () {},
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MulaiTest(),
        ));
        mulaiTestC.starCount();
        mulaiTestC.timeleft.value = 3;
        mulaiTestC.soal.value = 1;
        mulaiTestC.hasilJawaban.value = false;
      }
    }
    if (myC.currentTab.value == 1) {
      for (var i in myC.idx) {
        print("Juz " + i.toString());
        myC.getDetailJuz(juzNumber: i.toString());
      }
    }

    if (myC.currentTab.value == 2) {
      if (myC.customDataList.isNotEmpty) {
        for (var i in myC.customDataList) {
          List surah = i['surat'];
          myC.choiceSurah.add(i['surat']);
          for (var x in surah) {
            List ayahs = x['ayahs'];
            final numberRandom = Random().nextInt(ayahs.length) + 1;
            myC.tampunganSurah.add(ayahs[numberRandom]['text']);
            myC.tampunganJawaban.add(ayahs[numberRandom + 1]['text']);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MulaiTest(),
            ));
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // myC.quranSurah();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'Tes Hapalan',
            style: greenTextStyle.copyWith(),
          ),
          actions: [
            Image.asset("assets/assets/All icon1.png"),
            IconButton(
                onPressed: () {
                  Get.back();
                },
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
          padding: const EdgeInsets.all(17.0),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 131,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: greenC, borderRadius: BorderRadius.circular(10)),
                    child: Obx(() => myC.counterTest.value == 0
                        ? const Text(
                            'Belum ada tes yang\n dipilih ',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          )
                        : Text('Tes Dipilih ${myC.counterTest.value}',
                            style: TextStyle(color: Colors.white))),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        _actionMulai();
                        if (myC.choiceSurah.isNotEmpty) {
                          mulaiTestC.stopWatchTimer.onStartTimer();
                        }
                        // mulaiTestC.soal.value;

                        // mulaiTestC.soal.value;
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 115, bottom: 12),
                        height: 30,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 4,
                                  offset: Offset(0, 5))
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Mulai',
                              style: TextStyle(color: greenC),
                            ),
                            Container(
                                alignment: Alignment.center,
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: greenC,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Icon(
                                  Icons.play_arrow,
                                  size: 17,
                                  color: Colors.white,
                                )),
                            Text(
                              'Tes',
                              style: TextStyle(color: greenC),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.red[50]!, blurRadius: 10, spreadRadius: 1)
                ]),
                child: TextField(
                  // controller: myC.cariSurah,
                  onChanged: (val) {
                    myC.searhcValidate(val);
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Cari",
                      hintStyle: TextStyle(color: greenC),
                      suffixIcon: Icon(
                        Icons.search,
                        color: greenC,
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(
                    () => Column(
                      children: [
                        InkWell(
                            onTap: () {
                              myC.currentTab.value = 0;
                            },
                            child:
                                Text('Surah', style: TextStyle(color: greenC))),
                        SizedBox(
                          height: 5,
                        ),
                        myC.currentTab == 0
                            ? Container(
                                width: 25,
                                height: 2,
                                color: greenC,
                              )
                            : SizedBox()
                      ],
                    ),
                  ),
                  Obx(
                    () => Column(
                      children: [
                        InkWell(
                            onTap: () {
                              myC.currentTab.value = 1;
                            },
                            child:
                                Text('Juz', style: TextStyle(color: greenC))),
                        SizedBox(
                          height: 5,
                        ),
                        myC.currentTab == 1
                            ? Container(
                                width: 25,
                                height: 2,
                                color: greenC,
                              )
                            : SizedBox()
                      ],
                    ),
                  ),
                  Obx(
                    () => Column(
                      children: [
                        InkWell(
                            onTap: () {
                              myC.currentTab.value = 2;
                            },
                            child: Text('Costum',
                                style: TextStyle(color: greenC))),
                        SizedBox(
                          height: 5,
                        ),
                        myC.currentTab == 2
                            ? Container(
                                width: 25,
                                height: 2,
                                color: greenC,
                              )
                            : SizedBox()
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Obx(
                () => myC.currentTab == 0
                    ? surahData()
                    : myC.currentTab == 1
                        ? juzzzData()
                        : myC.customDataList.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                itemCount: myC.customDataList.length,
                                itemBuilder: (context, index) => Container(
                                  margin: EdgeInsets.only(bottom: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 5,
                                            color: Colors.grey,
                                            offset: Offset(0, 5))
                                      ]),
                                  child: ListTile(
                                      onTap: () {},
                                      title: Text(
                                        myC.customDataList[index]['nama_test'],
                                        style: TextStyle(
                                            color: greenC,
                                            fontWeight: semiBold),
                                      ),
                                      trailing: IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: ((context) {
                                                  return AlertDialog(
                                                    content: const Text(
                                                        "Apakah anda yakin ingin hapus ?"),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: (() {
                                                            Get.back();
                                                          }),
                                                          child: Text("Tidak")),
                                                      TextButton(
                                                          onPressed: (() {
                                                            myC.customDataList.removeWhere((element) =>
                                                                element[
                                                                    'nama_test'] ==
                                                                myC.customDataList[
                                                                        index][
                                                                    'nama_test']);
                                                            myC.counterTest
                                                                .value = myC
                                                                        .counterTest
                                                                        .value ==
                                                                    1
                                                                ? 0
                                                                : myC.counterTest
                                                                        .value -
                                                                    1;
                                                            Get.back();
                                                          }),
                                                          child: Text("Ya"))
                                                    ],
                                                  );
                                                }));
                                            // myC.deleteNote(note.id!);
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )),
                                      subtitle: Text("Ayat ke " +
                                          myC.customDataList[index]['dari'] +
                                          " - " +
                                          myC.customDataList[index]['sampai']),
                                      leading: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/assets/numbering.png'))),
                                        child: Image.asset(
                                            'assets/assets/quran (1) 5.png'),
                                      )),
                                ),
                              ))
                            : Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  LottieBuilder.asset(
                                    "assets/assets/lottie/created.json",
                                    width: 200,
                                  ),
                                  Text(
                                    'Belum ada Custom yang dibuat,\nKlik tombol tambah untuk\nmembuat Custom Test',
                                    style: TextStyle(color: Color(0xff6A6A6A)),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
              )
            ],
          ),
        ),
        floatingActionButton: Obx(
          () => myC.currentTab.value == 2
              ? FloatingActionButton(
                  backgroundColor: greenC,
                  onPressed: () {
                    myC.namaTestC.clear();
                    myC.ayatDariC.clear();
                    myC.sampaiAyatC.clear();
                    myC.suratCustum.clear();
                    dialogCostum(context);
                  },
                  child: Icon(Icons.add),
                )
              : SizedBox(),
        ));
  }

  // Batas Koding UI
  Future<dynamic> dialogCostum(BuildContext context) {
    return showDialog(
        context: context,
        builder: (dialogContext) {
          String nameS = "";

          // The .sw comes from flutter screen utils package... similar
          // to mediaquery height and width
          return AlertDialog(
              titlePadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              title: Container(
                width: double.infinity,
                height: 95,
                decoration: BoxDecoration(
                    color: greenC, borderRadius: BorderRadius.circular(30)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/assets/dialog.png'),
                      Image.asset('assets/assets/Group 253.png'),
                      Image.asset('assets/assets/dialog2.png'),
                    ]),
              ),
              content: Container(
                height: 300,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Nama Tes     : ',
                          style: TextStyle(fontWeight: semiBold),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        SizedBox(
                            width: 100,
                            height: 20,
                            child: TextField(
                              controller: myC.namaTestC,
                              // onChanged: (value) {
                              //   myC.namTest.add(myC.namaTestC);
                              // },
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Row(
                      children: [
                        Text(
                          'Nama Surat  :',
                          style: TextStyle(fontWeight: semiBold),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            width: 90,
                            height: 40,
                            child: DropdownFormField(
                                onEmptyActionPressed: () async {},
                                decoration: InputDecoration(
                                    iconColor: Colors.black45,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 1.0)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 1.0)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 1.0)),
                                    suffixIcon: Icon(Icons.arrow_drop_down),
                                    labelText: "Pilih surah"),
                                onSaved: (dynamic str) {},
                                onChanged: (dynamic str) {
                                  List ayahs = str['ayahs'];
                                  myC.nameSurahs.value = str['englishName'];
                                  myC.suratCustum.add(str);
                                  myC.lenghtAyahsCustom.value = ayahs.length;

                                  // controller.labelSku.value = str['SKU'];
                                  // controller.valueSku.value = str['id62'];
                                },
                                displayItemFn: (dynamic item) {
                                  if (item != null) {}

                                  return Obx(
                                    () => Text(
                                      myC.nameSurahs.value,
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  );
                                },
                                findFn: (dynamic str) async => myC.allSurah,
                                selectedFn: (dynamic item1, dynamic item2) {
                                  if (item1 != null && item2 != null) {
                                    return item1['englishName'] ==
                                        item2['englishName'];
                                  }
                                  return false;
                                },
                                filterFn: (dynamic item, str) =>
                                    item['englishName']
                                        .toLowerCase()
                                        .indexOf(str.toLowerCase()) >=
                                    0,
                                dropdownItemFn: (dynamic item,
                                    int position,
                                    bool focused,
                                    bool selected,
                                    Function() onTap) {
                                  return ListTile(
                                    title: Text(
                                      item['englishName'],
                                    ),
                                    tileColor: focused
                                        ? Color.fromARGB(20, 0, 0, 0)
                                        : Colors.transparent,
                                    onTap: onTap,
                                  );
                                }),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(() =>
                        Text("Surah Yang Di pilih : " + myC.nameSurahs.value)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Ayat :',
                      style: TextStyle(fontWeight: semiBold),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Text(
                          'Dari          : ',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        SizedBox(
                            width: 100,
                            height: 25,
                            child: Obx(
                              () => myC.lenghtAyahsCustom.value != 0
                                  ? TextFormField(
                                      onChanged: ((value) {
                                        print("cek " + value.toString());
                                        if (int.parse(value) <
                                            myC.lenghtAyahsCustom.value) {
                                          print("masuk");
                                        }
                                      }),
                                      keyboardType: TextInputType.number,
                                      controller: myC.ayatDariC,
                                      decoration: InputDecoration(),
                                    )
                                  : SizedBox(),
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        Text('Sampai    : ', style: TextStyle(fontSize: 14)),
                        SizedBox(
                          width: 6,
                        ),
                        SizedBox(
                            width: 100,
                            height: 25,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: myC.sampaiAyatC,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: greenC,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            onPressed: () async {
                              // myC.addNote();
                              // await myC.getAllNotes();
                              if (myC.namaTestC.text == "" ||
                                  myC.ayatDariC.text == "" ||
                                  myC.sampaiAyatC.text == "") {
                                Get.defaultDialog(title: "filled no empty!");
                              } else {
                                // myC.tampunganNamaTest.add(myC.namaTestC.text);
                                // myC.tampunganAyatDari.add(myC.ayatDariC.text);
                                // myC.tampunganSamapaiAyat
                                //     .add(myC.sampaiAyatC.text);
                                // print(myC.tampunganNamaTest);
                                // Get.back();
                                // myC.increment();

                                for (var i in myC.suratCustum) {
                                  print("oke : " + i['englishName'].toString());
                                  myC.customDataList.add({
                                    "nama_test": myC.namaTestC.text,
                                    "surat": [i],
                                    "dari": myC.ayatDariC.text,
                                    "sampai": myC.sampaiAyatC.text
                                  });
                                  myC.counterTest.value =
                                      myC.customDataList.length;
                                }
                                Get.back();
                              }
                            },
                            child: Text(
                              'Simpan',
                              style: TextStyle(
                                  color: Colors.white, fontWeight: semiBold),
                            )))
                  ],
                ),
              )
              // content: Column(
              //   children: [

              //   ],
              );
        });
  }

  Expanded surahData() {
    return Expanded(
        child: Obx(
      () => myC.allSurah.isNotEmpty
          ? Obx(() => myC.searchList.isEmpty
              ? ListView.builder(
                  itemCount: myC.allSurah.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => ListTile(
                      title: Text(
                        "${myC.allSurah[index]['name']}",
                        style: TextStyle(color: greenC),
                      ),
                      subtitle: Text(
                        "${myC.allSurah[index]['englishName']}",
                        style: TextStyle(color: greenC),
                      ),
                      leading: Container(
                          alignment: Alignment.center,
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/assets/VectorAyat.png'))),
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(color: greenC),
                          )),
                      trailing: Obx(() => myC.load.value == false
                          ? myC.dataCount[index]['value'] == true.obs
                              ? Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      color: greenC,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: InkWell(
                                    onTap: () {
                                      //
                                      myC.counterMin(
                                          myC.dataCount[index]['index'],
                                          myC.dataCount[index]);
                                      myC.tampunganSurah.removeLast();
                                      myC.tampunganJawaban.removeLast();
                                      myC.tampunganSurahEnglishName
                                          .removeLast();
                                      myC.counterTest.value =
                                          myC.counterTest.value - 1;
                                    },
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                  ))
                              : Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      color: greenC,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: InkWell(
                                    onTap: () {
                                      myC.counter(myC.dataCount[index]['index'],
                                          myC.dataCount[index]);
                                      List lengthS =
                                          myC.allSurah[index]['ayahs'];
                                      print(
                                          "Cek : " + lengthS.length.toString());
                                      final numberRandom =
                                          Random().nextInt(lengthS.length);

                                      myC.tampunganSurahEnglishName.add(
                                          myC.allSurah[index]['englishName']);
                                      myC.tampunganSurah.add(myC.allSurah[index]
                                          ['ayahs'][numberRandom]['text']);
                                      myC.tampunganJawaban.add(
                                          myC.allSurah[index]['ayahs']
                                              [numberRandom + 1]['text']);

                                      //         myC.tampunganSurah.add(myC.allSurah[index]['ayahs']
                                      // [myC.number]['text']);
                                      // print(myC.tampunganSurah);
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                          : Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  color: greenC,
                                  borderRadius: BorderRadius.circular(100)),
                              child: InkWell(
                                onTap: () {
                                  myC.counter(myC.dataCount[index]['index'],
                                      myC.dataCount[index]);
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              )))),
                )
              : ListView.builder(
                  itemCount: myC.searchList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => ListTile(
                      title: Text(
                        "${myC.searchList[index]['name']}",
                        style: TextStyle(color: greenC),
                      ),
                      subtitle: Text(
                        "${myC.searchList[index]['englishName']}",
                        style: TextStyle(color: greenC),
                      ),
                      leading: Container(
                          alignment: Alignment.center,
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/assets/VectorAyat.png'))),
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(color: greenC),
                          )),
                      trailing: Obx(() => myC.load.value == false
                          ? myC.dataCountSearch[index]['value'] == true.obs
                              ? Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      color: greenC,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: InkWell(
                                    onTap: () {
                                      //
                                      myC.counterTest.value =
                                          myC.counterTest.value == 1
                                              ? 0
                                              : myC.counterTest.value - 1;

                                      myC.counterMinSearch(
                                          myC.dataCountSearch[index]['index'],
                                          myC.dataCountSearch[index]);
                                      myC.tampunganSurah.removeLast();
                                      myC.tampunganJawaban.removeLast();
                                      myC.tampunganSurahEnglishName
                                          .removeLast();
                                    },
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                  ))
                              : Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      color: greenC,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: InkWell(
                                    onTap: () {
                                      myC.counterTest.value =
                                          myC.counterTest.value + 1;
                                      myC.counterSearch(
                                          myC.dataCountSearch[index]['index'],
                                          myC.dataCountSearch[index]);
                                      List lengthS =
                                          myC.searchList[index]['ayahs'];
                                      print(
                                          "Cek : " + lengthS.length.toString());
                                      final numberRandom =
                                          Random().nextInt(lengthS.length);

                                      myC.tampunganSurahEnglishName.add(
                                          myC.searchList[index]['englishName']);
                                      myC.tampunganSurah.add(
                                          myC.searchList[index]['ayahs']
                                              [numberRandom]['text']);
                                      myC.tampunganJawaban.add(
                                          myC.searchList[index]['ayahs']
                                              [numberRandom + 1]['text']);

                                      //         myC.tampunganSurah.add(myC.allSurah[index]['ayahs']
                                      // [myC.number]['text']);
                                      // print(myC.tampunganSurah);
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                          : Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  color: greenC,
                                  borderRadius: BorderRadius.circular(100)),
                              child: InkWell(
                                onTap: () {
                                  myC.counterSearch(
                                      myC.dataCountSearch[index]['index'],
                                      myC.dataCountSearch[index]);
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              )))),
                ))
          : Center(
              child: Lottie.asset(
              'assets/assets/lottie/loading.json',
              width: 200,
            )),
    ));
  }

  Expanded juzzzData() {
    return Expanded(
        child: Obx(() => myC.searchListJuzz.isEmpty
            ? ListView.builder(
                itemCount: myC.allJuzz.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => ListTile(
                    title: Text(
                      "Juz " + myC.allJuzz[index]['juz_number'].toString(),
                      style: TextStyle(color: greenC),
                    ),
                    leading: Container(
                        alignment: Alignment.center,
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/assets/VectorAyat.png'))),
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(color: greenC),
                        )),
                    trailing: Obx(() => myC.load.value == false
                        ? myC.dataCountJuzz[index]['value'] == true.obs
                            ? Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    color: greenC,
                                    borderRadius: BorderRadius.circular(100)),
                                child: InkWell(
                                  onTap: () {
                                    //
                                    myC.counterTest.value =
                                        myC.counterTest.value == 1
                                            ? 0
                                            : myC.counterTest.value - 1;

                                    myC.counterMinjuzz(
                                        myC.dataCountJuzz[index]['index'],
                                        myC.dataCountJuzz[index]);
                                  },
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                ))
                            : Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    color: greenC,
                                    borderRadius: BorderRadius.circular(100)),
                                child: InkWell(
                                  onTap: () {
                                    myC.counterTest.value =
                                        myC.counterTest.value + 1;

                                    myC.counterjuzz(
                                        myC.dataCountJuzz[index]['index'],
                                        myC.dataCountJuzz[index]);
                                    //         myC.tampunganSurah.add(myC.allSurah[index]['ayahs']
                                    // [myC.numberRandom]['text']);
                                    // print("halooo" + myC.tampunganSurah.toString());

                                    //         myC.tampunganSurah.add(myC.allSurah[index]['ayahs']
                                    // [myC.number]['text']);
                                    // print(myC.tampunganSurah);
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                        : Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                color: greenC,
                                borderRadius: BorderRadius.circular(100)),
                            child: InkWell(
                              onTap: () {
                                myC.counterTest.value =
                                    myC.counterTest.value + 1;
                                myC.counterjuzz(
                                    myC.dataCountJuzz[index]['index'],
                                    myC.dataCountJuzz[index]);
                              },
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            )))),
              )
            : ListView.builder(
                itemCount: myC.searchListJuzz.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => ListTile(
                      title: Text(
                        "${myC.searchListJuzz[index]['text']}",
                        style: TextStyle(color: greenC),
                      ),
                      subtitle: Text(
                        "${myC.searchListJuzz[index]['surah']['englishName']}",
                        style: TextStyle(color: greenC),
                      ),
                      leading: Container(
                          alignment: Alignment.center,
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/assets/VectorAyat.png'))),
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(color: greenC),
                          )),
                      trailing: Obx(
                        () => Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              color: greenC,
                              borderRadius: BorderRadius.circular(100)),
                          child: myC.addTest.isFalse
                              ? InkWell(
                                  onTap: () {
                                    myC.addTest.toggle();
                                    myC.increment();
                                    myC.tesSelected();
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    myC.addTest.toggle();
                                    myC.decrement();
                                    myC.tesSelected();
                                  },
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ))));
  }

  // FutureBuilder<dynamic> juzzData() {
  //   return FutureBuilder(
  //       future: myC.quranJuzz(),
  //       builder: (context, snap) {
  //         // if (snap.connectionState == ConnectionState.waiting) {
  //         //   CircularProgressIndicator();
  //         // }
  //         return Expanded(
  //             child: ListView.builder(
  //                 itemCount: myC.allJuzz.length,
  //                 shrinkWrap: true,
  //                 itemBuilder: (context, index) => ListTile(
  //                       title: Text(
  //                         "${myC.allJuzz[index]['text']}",
  //                         style: TextStyle(color: greenC),
  //                       ),
  //                       subtitle: Text(
  //                         "${myC.allJuzz[index]['surah']['englishName']}",
  //                         style: TextStyle(color: greenC),
  //                       ),
  //                       leading: Container(
  //                           alignment: Alignment.center,
  //                           width: 35,
  //                           height: 35,
  //                           decoration: BoxDecoration(
  //                               image: DecorationImage(
  //                                   image:
  //                                       AssetImage('assets/VectorAyat.png'))),
  //                           child: Text(
  //                             "${index + 1}",
  //                             style: TextStyle(color: greenC),
  //                           )),
  //                       trailing: Container(
  //                         height: 25,
  //                         width: 25,
  //                         decoration: BoxDecoration(
  //                             color: greenC,
  //                             borderRadius: BorderRadius.circular(100)),
  //                         child: Icon(
  //                           Icons.add,
  //                           color: Colors.white,
  //                         ),
  //                       ),
  //                     )));
  //       });
  // }
}

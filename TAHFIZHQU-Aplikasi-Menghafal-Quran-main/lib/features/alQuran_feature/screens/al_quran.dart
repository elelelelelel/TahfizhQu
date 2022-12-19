import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tahfizh_qu_app/features/alQuran_feature/screens/widgets/custom_search.dart';
import 'package:tahfizh_qu_app/features/alQuran_feature/screens/widgets/custom_surah_tile.dart';
import 'package:tahfizh_qu_app/features/alQuran_feature/view_model/alQuran_view_model.dart';
import 'package:tahfizh_qu_app/res/tahfidzqu_colors.dart';
import 'package:tahfizh_qu_app/utils/widgets/custom_app_bar.dart';

class AlQuran extends StatefulWidget {
  // const AlQuran({super.key});

  @override
  State<AlQuran> createState() => _AlQuranState();
}

class _AlQuranState extends State<AlQuran> {
  TextEditingController searchCont = TextEditingController();
  AlQuranViewModel alQuranViewModel = AlQuranViewModel();

  @override
  void initState() {
    alQuranViewModel.fetchListOfSurahApi(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: CustomAppBar(
            title: "Al Quran",
            showDownloadButton: false,
            onBackButton: () {
              Navigator.pop(context);
            },
            onDownloadButton: () {},
            onListButton: () {},
            onMenuButton: () {},
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Container(
                  height: 140,
                  width: Get.width,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: TahfidzQuColors.mainGreen.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/bg_ngaji.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svg/icon_baca.svg",
                                semanticsLabel: 'icon_baca',
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Terakhir Dibaca',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Al-Fatihah',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Ayat No: 1',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Image.asset("assets/images/logo_ahlul_quran.png"),
                    ],
                  ),
                ),

                // SEARCH FITUR
                const SizedBox(height: 24),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: CustomSearchBar(
                    searchContr: searchCont,
                    onSearchButton: () {},
                  ),
                ),
                const SizedBox(height: 8),
                TabBar(
                  labelColor: TahfidzQuColors.mainGreen,
                  indicatorColor: TahfidzQuColors.mainGreen,
                  tabs: const [
                    Tab(text: 'Surah'),
                    Tab(text: 'Juz'),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: Get.height / 2.2,
                  child: const TabBarView(
                    children: [
                      CustomSurahTile(),
                      Text('Isi Juz'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

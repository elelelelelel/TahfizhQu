import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tahfizh_qu_app/features/hafalan_feature/pages/home/homepage.dart';
import 'package:tahfizh_qu_app/features/hafalan_feature/pages/mulai_test/mulai_tes.dart';
import 'package:tahfizh_qu_app/features/home_feature/screens/widgets/menu_option.dart';
import 'package:tahfizh_qu_app/res/tahfidzqu_colors.dart';
import 'package:tahfizh_qu_app/utils/routes/routes_names.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 160,
                  ),
                  Text(
                    "TahfizhQu",
                    style: GoogleFonts.poppins(
                      color: TahfidzQuColors.mainGreen,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                          'Motivasi',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Sebaik - baik manusia diantara kamu adalah yang mempelajari Al-Quran dan mengajarkannya (HR Bukhori)',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MenuOption(
                    onTapMenu: () {
                      Navigator.pushNamed(context, RoutesNames.alQuran);
                    },
                    titleColor: Colors.white,
                    bgColor: TahfidzQuColors.mainGreen,
                    icon: SvgPicture.asset(
                      "assets/svg/quran_icon.svg",
                      semanticsLabel: 'icon',
                    ),
                    title: "Al Quran",
                    bgImg: "assets/images/quran.jpg",
                  ),
                  MenuOption(
                    onTapMenu: () {
                      print('tapped');
                      Get.to(HomePage());
                    },
                    bgColor: Colors.white,
                    titleColor: TahfidzQuColors.mainGreen,
                    icon: Image.asset("assets/images/hafalan.png"),
                    title: "Tes Hafalan",
                    bgImg: "assets/images/quran.jpg",
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MenuOption(
                    onTapMenu: () {
                      final snackBar = SnackBar(
                        duration: Duration(milliseconds: 700),
                        content: const Text('Under Development !'),
                        backgroundColor: (Colors.red),
                        action: SnackBarAction(
                          label: '',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      print('tapped');
                    },
                    bgColor: Colors.white,
                    titleColor: TahfidzQuColors.mainGreen,
                    icon: const Icon(
                      Icons.games_rounded,
                      size: 56,
                      color: Color(0xFFD38545),
                    ),
                    title: "Game",
                    bgImg: "assets/images/quran.jpg",
                  ),
                  InkWell(
                    child: MenuOption(
                      onTapMenu: () {
                        final snackBar = SnackBar(
                          duration: Duration(milliseconds: 700),
                          content: const Text('Under Development !'),
                          backgroundColor: (Colors.red),
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        print('tapped');
                      },
                      titleColor: Colors.white,
                      bgColor: TahfidzQuColors.mainGreen,
                      icon: SvgPicture.asset(
                        "assets/svg/goals.svg",
                        semanticsLabel: 'icon',
                      ),
                      title: "Goals",
                      bgImg: "assets/images/quran.jpg",
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

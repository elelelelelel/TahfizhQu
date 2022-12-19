import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tahfizh_qu_app/res/tahfidzqu_colors.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({
    required this.title,
    required this.onBackButton,
    required this.onDownloadButton,
    required this.onListButton,
    required this.onMenuButton,
    required this.showDownloadButton,
    Key? key,
  }) : super(key: key);

  String title;
  Function onBackButton;
  Function onListButton;
  Function onDownloadButton;
  Function onMenuButton;
  bool showDownloadButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: TahfidzQuColors.whiteBackground, //change your color here
      ),
      backgroundColor: TahfidzQuColors.whiteBackground,
      elevation: 0.0,
      leading: IconButton(
        onPressed: () {
          onBackButton();
        },
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 20,
          color: TahfidzQuColors.mainGreen,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: TahfidzQuColors.mainGreen,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            onDownloadButton();
          },
          icon: SvgPicture.asset(
            "assets/svg/list_download.svg",
            semanticsLabel: 'list_download',
          ),
        ),
        showDownloadButton
            ? IconButton(
                onPressed: () {
                  onDownloadButton();
                },
                icon: SvgPicture.asset(
                  "assets/svg/download.svg",
                  semanticsLabel: 'download',
                ),
              )
            : Container(),
        IconButton(
          onPressed: () {
            onMenuButton();
          },
          icon: SvgPicture.asset(
            "assets/svg/menu.svg",
            semanticsLabel: 'menu',
          ),
        )
      ],
    );
  }
}

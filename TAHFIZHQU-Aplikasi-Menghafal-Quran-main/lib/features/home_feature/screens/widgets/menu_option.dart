import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuOption extends StatelessWidget {
  MenuOption({
    required this.title,
    required this.icon,
    required this.bgColor,
    required this.bgImg,
    required this.titleColor,
    required this.onTapMenu,
    Key? key,
  }) : super(key: key);

  final Widget icon;
  final String title;
  final Color titleColor;
  final Color bgColor;
  final String bgImg;
  Function onTapMenu;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTapMenu();
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          height: 166,
          width: 148,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            // quran
            color: bgColor,
            // image: DecorationImage(
            //   image: AssetImage(bgImg),
            //   fit: BoxFit.cover,
            // ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              icon,
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: titleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

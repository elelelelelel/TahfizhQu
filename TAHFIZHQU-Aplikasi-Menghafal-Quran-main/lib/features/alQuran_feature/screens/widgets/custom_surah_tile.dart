import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svgProvider;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tahfizh_qu_app/data/response/status.dart';
import 'package:tahfizh_qu_app/features/alQuran_feature/view_model/alQuran_view_model.dart';
import 'package:tahfizh_qu_app/res/tahfidzqu_colors.dart';

class CustomSurahTile extends StatefulWidget {
  const CustomSurahTile({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomSurahTile> createState() => _CustomSurahTileState();
}

class _CustomSurahTileState extends State<CustomSurahTile> {
  AlQuranViewModel alQuranViewModel = AlQuranViewModel();

  @override
  void initState() {
    alQuranViewModel.fetchListOfSurahApi(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider<AlQuranViewModel>(
      create: (BuildContext context) => alQuranViewModel,
      child: Consumer<AlQuranViewModel>(
        builder: (context, value, _) {
          switch (value.listOfSurah.status) {
            case Status.LOADING:
              return Center(
                  child: CircularProgressIndicator(
                color: TahfidzQuColors.mainGreen,
              ));
            case Status.ERROR:
              return Center(child: Text(value.listOfSurah.message.toString()));
            case Status.COMPLETED:
              return ListView.separated(
                itemBuilder: (context, index) {
                  var surahItem = value.listOfSurah.data!.data![index];
                  var revelation =
                      surahItem.revelation!.id.toString().split('.');
                  var relevationAfterSplit = revelation[1];

                  return InkWell(
                    onTap: () {
                      print(surahItem.number);
                    },
                    child: ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image:
                                svgProvider.Svg("assets/svg/number_icon.svg"),
                          ),
                        ),
                        child: Text(
                          surahItem.number.toString(),
                          style: GoogleFonts.poppins(
                            color: TahfidzQuColors.mainGreen,
                          ),
                        ),
                      ),
                      title: Text(
                        surahItem.name!.transliteration!.id!,
                        style: GoogleFonts.poppins(
                          color: TahfidzQuColors.mainGreen,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            relevationAfterSplit,
                            style: GoogleFonts.poppins(
                              color: TahfidzQuColors.mainGrey.withOpacity(0.6),
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${surahItem.numberOfVerses.toString()} - Ayat',
                            style: GoogleFonts.poppins(
                              color: TahfidzQuColors.mainGrey.withOpacity(0.6),
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            surahItem.name!.short!,
                            style: GoogleFonts.poppins(
                              color: TahfidzQuColors.mainGreen,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.download_rounded,
                              color: TahfidzQuColors.mainGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(height: 2),
                itemCount: value.listOfSurah.data!.data!.length,
              );

            default:
          }
          return Container();
        },
      ),
    ));
  }
}

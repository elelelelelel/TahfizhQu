import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tahfizh_qu_app/res/tahfidzqu_colors.dart';

class CustomSearchBar extends StatefulWidget {
  CustomSearchBar({
    required this.searchContr,
    required this.onSearchButton,
    Key? key,
  }) : super(key: key);

  TextEditingController searchContr;
  Function onSearchButton;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.searchContr,
      cursorColor: TahfidzQuColors.mainGreen,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
          borderSide: BorderSide(width: 1, color: Colors.transparent),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
          borderSide: BorderSide(
            width: 0.1,
            color: Colors.white,
            style: BorderStyle.none,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
          borderSide: BorderSide(
            width: 0.1,
            color: Colors.white,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        hintStyle: TextStyle(color: TahfidzQuColors.mainGreen),
        hintText: "Cari",
        fillColor: Colors.white,
        suffixIcon: IconButton(
          onPressed: (widget.onSearchButton()),
          icon: Icon(
            Icons.search_rounded,
            color: TahfidzQuColors.mainGreen,
          ),
        ),
      ),
    );
  }
}

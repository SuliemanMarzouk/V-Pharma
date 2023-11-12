import 'package:flutter/material.dart';
import 'package:v_pharma/constant/colors.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: width * .5,
      child: TextField(
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 12),
        cursorHeight: 18,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: kPrimarycolor,
          ),
          contentPadding: EdgeInsets.all(5),
          hintText: "Search",
          hintMaxLines: 1,
          hintStyle: TextStyle(
            fontSize: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: kPrimarycolor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: kPrimarycolor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: kPrimarycolor,
            ),
          ),
        ),
      ),
    );
  }
}

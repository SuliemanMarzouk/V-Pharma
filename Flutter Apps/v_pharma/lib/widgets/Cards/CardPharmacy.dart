import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:v_pharma/constant/colors.dart';

class CustomCardPharmacy extends StatelessWidget {
  String? namephar;
  String? addressphar;
  String? imagephar;
  bool? status;
  String? open;
  String? close;
  CustomCardPharmacy(
      {this.addressphar,
      this.close,
      this.imagephar,
      this.namephar,
      this.open,
      this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Card(
        elevation: 5,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: SizedBox(
                child: Image.asset(
                  imagephar!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      namephar!,
                      style: TextStyle(
                          color: kPrimarycolor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    Divider(
                      thickness: 1,
                      color: kBaseSecondryColor,
                    ),
                    AutoSizeText(
                      "Pharmacy Phone :",
                      style: TextStyle(
                          color: kBaseSecondryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                    AutoSizeText(
                      addressphar!,
                      style: TextStyle(
                          color: kPrimarycolor,
                          fontWeight: FontWeight.w300,
                          fontSize: 14),
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: status!
                                  ? Image.asset(
                                      'images/online.png',
                                      width: 25,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.asset(
                                      'images/offline.png',
                                      width: 25,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ],
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Divider(
                                thickness: 1,
                                endIndent: 45,
                                indent: 45,
                                color: kBaseSecondryColor,
                              ),
                              Center(
                                child: AutoSizeText(
                                  "opening hours",
                                  style: TextStyle(
                                      color: kBaseSecondryColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.access_time_outlined,
                                    color: kPrimarycolor,
                                  ),
                                  AutoSizeText(
                                    open!,
                                    style: TextStyle(
                                        color: kBaseSecondryColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                  AutoSizeText(
                                    "TO",
                                    style: TextStyle(
                                        color: kBaseSecondryColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                  AutoSizeText(
                                    close!,
                                    style: TextStyle(
                                        color: kBaseSecondryColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';
import 'package:v_pharma/Model/Medicine.dart';
import 'package:v_pharma/View/Customer/CartPage.dart';
import 'package:v_pharma/View/Customer/HomePage.dart';
import 'package:v_pharma/View/Customer/Search_Medicine.dart';
import 'package:v_pharma/constant/colors.dart';
import 'package:v_pharma/main.dart';
import 'package:v_pharma/widgets/Cards/CardMedicins.dart';
import 'package:v_pharma/widgets/SearchInput.dart';

class MedicinesPage extends StatelessWidget {
  List<Medicine>? listmedicine;
  String? Pharmacyname;
  int? id_pharma;
  MedicinesPage({this.id_pharma, this.listmedicine, this.Pharmacyname});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBaseColor,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: CartPage(), type: PageTransitionType.fade));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(
                Icons.shopping_cart,
                color: kPrimarycolor,
              ),
            ),
          )
        ],
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            icon: Icon(
              Icons.arrow_back,
              color: kPrimarycolor,
            )),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(children: [
        // SingleChildScrollView(
        //   physics: NeverScrollableScrollPhysics(),
        //   child: ColorFiltered(
        //       colorFilter: ColorFilter.mode(
        //           Colors.grey.withOpacity(0.4), BlendMode.dstATop),
        //       child: Image.asset('images/heximage.jpg', fit: BoxFit.cover)),
        // ),
        ListView(
          physics: BouncingScrollPhysics(),
          // shrinkWrap: true,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: AutoSizeText(
                    Pharmacyname!,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: kPrimarycolor),
                  ),
                ),
                Divider(
                  color: kBaseSecondryColor,
                  endIndent: 50,
                  indent: 50,
                  thickness: 1,
                  height: 3,
                ),
                Divider(
                  color: kBaseSecondryColor,
                  endIndent: 50,
                  indent: 50,
                  thickness: 1,
                  height: 3,
                ),
              ],
            ),
            GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: listmedicine!.length,
              itemBuilder: (context, index) => CardMedicine(
                  medicicne: listmedicine![index], id_pharma: id_pharma),
            )
          ],
        )
      ]),
    );
  }
}

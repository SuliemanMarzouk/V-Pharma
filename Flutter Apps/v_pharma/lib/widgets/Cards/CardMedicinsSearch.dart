import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v_pharma/Model/Medicine.dart';
import 'package:v_pharma/constant/colors.dart';
import 'package:v_pharma/main.dart';

class CardMedicineSearch extends StatelessWidget {
  CardMedicineSearch({this.medicicne, this.id_pharma});
  Medicine? medicicne;
  int? id_pharma;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                medicicne!.MedicineName,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Image.asset("images/medicene1.png"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${medicicne!.Price}\$", style: TextStyle(fontSize: 18)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

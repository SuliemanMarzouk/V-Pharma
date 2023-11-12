import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v_pharma/Model/Medicine.dart';
import 'package:v_pharma/constant/colors.dart';
import 'package:v_pharma/main.dart';

class CardMedicine extends StatelessWidget {
  CardMedicine({this.medicicne, this.id_pharma});
  Medicine? medicicne;
  int? id_pharma;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                medicicne!.MedicineName,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 120, // Adjust the height as per your needs
                child: Image.asset(
                  "images/medicene1.png",
                  fit: BoxFit.contain,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${medicicne!.Price}\$", style: TextStyle(fontSize: 18)),
                  GestureDetector(
                    onTap: () {
                      cartProvider.addToCart(
                        medicicne!,
                        context,
                      );
                    },
                    child: Icon(CupertinoIcons.add_circled),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

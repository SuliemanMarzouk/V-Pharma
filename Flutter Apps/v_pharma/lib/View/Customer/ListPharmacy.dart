import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:v_pharma/Controllers/PharmacyMedicineProvider.dart';
import 'package:v_pharma/View/Customer/MedicinesPage.dart';
import 'package:v_pharma/constant/colors.dart';
import 'package:v_pharma/main.dart';
import 'package:v_pharma/widgets/Cards/CardPharmacy.dart';

class ListPharmacy extends StatefulWidget {
  const ListPharmacy({super.key});

  @override
  State<ListPharmacy> createState() => _ListPharmacyState();
}

class _ListPharmacyState extends State<ListPharmacy> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      await pharmacyMedicineProvider.getpharmacymedicine();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    pharmacyMedicineProvider = Provider.of<PharmacyMedicineProvider>(context);

    return pharmacyMedicineProvider.isloadinggetpharmacymedicine
        ? Center(
            child: CircularProgressIndicator(
              color: kPrimarycolor,
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: pharmacyMedicineProvider.listpharmacy.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                if (pharmacyMedicineProvider.listpharmacy[index].status!) {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: MedicinesPage(
                            id_pharma:
                                pharmacyMedicineProvider.listpharmacy[index].id,
                            Pharmacyname: pharmacyMedicineProvider
                                .listpharmacy[index].PharmaName,
                            listmedicine: pharmacyMedicineProvider
                                .listpharmacy[index].listmedicine,
                          ),
                          type: PageTransitionType.fade));
                }
              },
              child: CustomCardPharmacy(
                addressphar: pharmacyMedicineProvider
                    .listpharmacy[index].PhoneNum
                    .toString(),
                imagephar: "images/phar1.png",
                namephar:
                    pharmacyMedicineProvider.listpharmacy[index].PharmaName,
                status: pharmacyMedicineProvider.listpharmacy[index].status,
                open: "6 AM",
                close: "12 PM",
              ),
            ),

            // children: [
            //   CustomCardPharmacy(
            //     addressphar: "",
            //     imagephar: "images/phar1.png",
            //     namephar: "AL KAMEL PHARMACY",
            //     status: true,
            //     open: "6 AM",
            //     close: "12 PM",
            //   ),
            // ],
          );
  }
}

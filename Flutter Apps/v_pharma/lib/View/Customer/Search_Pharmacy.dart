import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:v_pharma/Controllers/CartProvider.dart';
import 'package:v_pharma/Controllers/PharmacyMedicineProvider.dart';
import 'package:v_pharma/Model/Pharmacy.dart';
import 'package:v_pharma/View/Customer/ListPharmacy.dart';
import 'package:v_pharma/View/Customer/MedicinesPage.dart';
import 'package:v_pharma/main.dart';
import 'package:v_pharma/widgets/Cards/CardPharmacy.dart';

class SearchPharmacy extends SearchDelegate<void> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    pharmacyMedicineProvider = Provider.of<PharmacyMedicineProvider>(context);
    List<Pharmacy> searchCategory =
        pharmacyMedicineProvider.searchPharmacyList(query);

    return ListView(
        children: searchCategory
            .map((e) => GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => MedicinesPage(
                        Pharmacyname: e.PharmaName,
                        id_pharma: e.id,
                        listmedicine: e.listmedicine,
                      ),
                    ),
                  );
                },
                child: CustomCardPharmacy(
                  addressphar: e.PhoneNum,
                  namephar: e.PharmaName,
                  imagephar: "images/phar1.png",
                  open: "6 AM",
                  close: "12 PM",
                  status: e.status,
                )))
            .toList());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    pharmacyMedicineProvider = Provider.of<PharmacyMedicineProvider>(context);
    List<Pharmacy> searchCategory =
        pharmacyMedicineProvider.searchPharmacyList(query);
    return ListView(
        children: searchCategory
            .map((e) => GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => MedicinesPage(
                        Pharmacyname: e.PharmaName,
                        id_pharma: e.id,
                        listmedicine: e.listmedicine,
                      ),
                    ),
                  );
                },
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomCardPharmacy(
                      addressphar: e.PhoneNum.toString(),
                      namephar: e.PharmaName,
                      imagephar: "images/phar1.png",
                      open: "6 AM",
                      close: "12 PM",
                      status: e.status,
                    ))))
            .toList());
  }
}

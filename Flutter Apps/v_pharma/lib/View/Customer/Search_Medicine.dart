import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:v_pharma/Controllers/CartProvider.dart';
import 'package:v_pharma/Controllers/PharmacyMedicineProvider.dart';
import 'package:v_pharma/Model/Medicine.dart';
import 'package:v_pharma/Model/Pharmacy.dart';
import 'package:v_pharma/View/Customer/ListPharmacy.dart';
import 'package:v_pharma/View/Customer/MedicinesPage.dart';
import 'package:v_pharma/main.dart';
import 'package:v_pharma/widgets/Cards/CardMedicins.dart';
import 'package:v_pharma/widgets/Cards/CardMedicinsSearch.dart';
import 'package:v_pharma/widgets/Cards/CardPharmacy.dart';

class SearchMedicine extends SearchDelegate<void> {
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
    List<Medicine> searchCategory =
        pharmacyMedicineProvider.searchMedicineList(query);

    return GridView(
        physics: BouncingScrollPhysics(),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: searchCategory
            .map((e) => GestureDetector(
                onTap: () {
                  pharmacyMedicineProvider.listpharmacy
                      .where((element) => element.id == e.PharmacyID)
                      .first
                      .PharmaName;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => MedicinesPage(
                        Pharmacyname: pharmacyMedicineProvider.listpharmacy
                            .where((element) => element.id == e.PharmacyID)
                            .first
                            .PharmaName,
                        id_pharma: pharmacyMedicineProvider.listpharmacy
                            .where((element) => element.id == e.PharmacyID)
                            .first
                            .id,
                        listmedicine: pharmacyMedicineProvider.listpharmacy
                            .where((element) => element.id == e.PharmacyID)
                            .first
                            .listmedicine,
                      ),
                    ),
                  );
                },
                child: CardMedicineSearch(
                  id_pharma: pharmacyMedicineProvider.listpharmacy
                      .where((element) => element.id == e.PharmacyID)
                      .first
                      .id,
                  medicicne: e,
                )))
            .toList());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    pharmacyMedicineProvider = Provider.of<PharmacyMedicineProvider>(context);
    List<Medicine> searchCategory =
        pharmacyMedicineProvider.searchMedicineList(query);
    return GridView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: searchCategory
            .map((e) => GestureDetector(
                onTap: () {
                  pharmacyMedicineProvider.listpharmacy
                      .where((element) => element.id == e.PharmacyID)
                      .first
                      .PharmaName;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => MedicinesPage(
                        Pharmacyname: pharmacyMedicineProvider.listpharmacy
                            .where((element) => element.id == e.PharmacyID)
                            .first
                            .PharmaName,
                        id_pharma: pharmacyMedicineProvider.listpharmacy
                            .where((element) => element.id == e.PharmacyID)
                            .first
                            .id,
                        listmedicine: pharmacyMedicineProvider.listpharmacy
                            .where((element) => element.id == e.PharmacyID)
                            .first
                            .listmedicine,
                      ),
                    ),
                  );
                },
                child: CardMedicineSearch(
                  id_pharma: pharmacyMedicineProvider.listpharmacy
                      .where((element) => element.id == e.PharmacyID)
                      .first
                      .id,
                  medicicne: e,
                )))
            .toList());
  }
}

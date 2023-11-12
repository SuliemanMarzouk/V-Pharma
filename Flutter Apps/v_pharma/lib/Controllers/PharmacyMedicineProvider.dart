import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:v_pharma/Model/Medicine.dart';
import 'package:v_pharma/Model/Pharmacy.dart';
import 'package:v_pharma/constant/API-Url.dart';

class PharmacyMedicineProvider with ChangeNotifier {
  bool isloadinggetpharmacymedicine = false;
  List<Pharmacy> listpharmacy = [];
  Pharmacy pharmacy = Pharmacy();
  List<Medicine> listmedicine = [];
  List<Medicine> listallmedicine = [];
  List<Medicine> listCartmedicine = [];
  Medicine medicine = Medicine();

  Future<void> getpharmacymedicine() async {
    isloadinggetpharmacymedicine = true;
    notifyListeners();
    listallmedicine = [];
    listpharmacy = [];
    notifyListeners();
    http.Response response;

    try {
      response = await http.get(
        Uri.parse('$baseURL${AppApi.GetAllPharmacyMedicine}'),
        headers: {
          'Accept': 'application/json',
        },
      );

      print(response.statusCode);
      // print(response.body);
      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        // print(data[0]);
        for (var element in data) {
          listmedicine = [];
          notifyListeners();

          pharmacy = Pharmacy(
            PharmaLicense: element['PharmaLicense'],
            PharmaName: element['PharmaName'],
            PhoneNum: element['PhoneNum'],
            id: element['ID'],
            pharmacistName: element['pharmacistName'],
            status: element['status'] == 1 ? true : false,
          );
          for (var medicinefrompharmacy in element['medicines']) {
            medicine = Medicine(
              ExpireDate: medicinefrompharmacy['ExpireDate'],
              MedicineDetails: medicinefrompharmacy['MedicineDetails'],
              MedicineName: medicinefrompharmacy['MedicineName'],
              Price: medicinefrompharmacy['pivot']['Price'],
              id: medicinefrompharmacy['ID'],
              ProductionDate: medicinefrompharmacy['ProductionDate'],
              Quantity: medicinefrompharmacy['pivot']['Quantity'],
              PharmacyID: medicinefrompharmacy['pivot']['PharmacyID'],
            );
            listallmedicine.add(medicine);
            listmedicine.add(medicine);
          }
          pharmacy.listmedicine = listmedicine;
          listpharmacy.add(pharmacy);
          notifyListeners();
          //   print(pharmacy.PharmaName);
        }
        print(listallmedicine.length);
        isloadinggetpharmacymedicine = false;
        notifyListeners();
        // print(await response.body);
      } else {
        // print(response.reasonPhrase);
        isloadinggetpharmacymedicine = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      isloadinggetpharmacymedicine = false;
      notifyListeners();
    }
  }

  late List<Pharmacy> searchepharmacylist;
  void getSearchPharmacyList({required List<Pharmacy> list}) {
    searchepharmacylist = list;
  }

  List<Pharmacy> searchPharmacyList(String query) {
    List<Pharmacy> searchpharmacy = searchepharmacylist.where((element) {
      return element.PharmaName!.toUpperCase().contains(query) ||
          element.PharmaName!.toLowerCase().contains(query);
    }).toList();
    return searchpharmacy;
  }

  late List<Medicine> searchmedicinelist;
  void getSearchMedicineList({required List<Medicine> list}) {
    searchmedicinelist = list;
  }

  List<Medicine> searchMedicineList(String query) {
    List<Medicine> searchmedicine = searchmedicinelist.where((element) {
      return element.MedicineName!.toUpperCase().contains(query) ||
          element.MedicineName!.toLowerCase().contains(query);
    }).toList();
    return searchmedicine;
  }
}

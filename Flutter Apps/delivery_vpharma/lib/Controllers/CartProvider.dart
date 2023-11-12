import 'dart:convert';
import 'dart:math';
import 'package:another_flushbar/flushbar.dart';
import 'package:delivery_vpharma/Controllers/AuthProvider.dart';
import 'package:delivery_vpharma/Model/OrderPharmacy.dart';
import 'package:delivery_vpharma/Model/Pharmacy.dart';
import 'package:delivery_vpharma/Model/User.dart';
import 'package:delivery_vpharma/Model/Warehouse.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:delivery_vpharma/Model/Cart.dart';
import 'package:delivery_vpharma/Model/Medicine.dart';
import 'package:delivery_vpharma/Model/OrderCustomer.dart';
import 'package:delivery_vpharma/constant/API-Url.dart';

class CartProvider extends ChangeNotifier {
  AuthProvider authProvider = AuthProvider();
  bool isLoadinggetallordercutomer = false;
  bool isLoadinggetallorderpharmacy = false;
  bool isLoadingupdatestausorder = false;
  bool isLoadingupdatestausorderpharmacy = false;
  List<OrderCustomer> listordercustomer = [];
  OrderCustomer oredercustomer = OrderCustomer();
  List<OrderPharmacy> listorderpharmacy = [];
  OrderPharmacy orederpharmacy = OrderPharmacy();
  Future<bool> updatestausorder({int? idorder, int? status}) async {
    isLoadingupdatestausorder = false;
    notifyListeners();
    http.Response response;

    try {
      response = await http.put(
          Uri.parse('$baseURL${AppApi.DeliverySubmitOrder(idorder!)}'),
          headers: {
            'Accept': 'application/json',
          },
          body: {
            "OrderStatus": status!.toString()
          });

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        isLoadingupdatestausorder = false;
        notifyListeners();
        getallOrderCustomerfromdelivery();
        return true;
      } else {
        isLoadingupdatestausorder = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      isLoadingupdatestausorder = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updatestausorderpharmacy({int? idorder, int? status}) async {
    isLoadingupdatestausorderpharmacy = false;
    notifyListeners();
    http.Response response;

    try {
      response = await http.put(
          Uri.parse('$baseURL${AppApi.DeliverySubmitOrderPharmacy(idorder!)}'),
          headers: {
            'Accept': 'application/json',
          },
          body: {
            "OrderStatus": status!.toString()
          });

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        isLoadingupdatestausorderpharmacy = false;
        notifyListeners();

        getallOrderPharmacyfromdelivery();
        return true;
      } else {
        isLoadingupdatestausorderpharmacy = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      isLoadingupdatestausorderpharmacy = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> getallOrderCustomerfromdelivery() async {
    isLoadinggetallordercutomer = true;
    notifyListeners();
    listordercustomer = [];
    notifyListeners();
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt("DeleiveryID");
    print(id);
    try {
      response = await http.get(
        Uri.parse('$baseURL${AppApi.GetAllDeliveryOrder(id!)}'),
        headers: {
          'Accept': 'application/json',
        },
      );

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        for (var element in data['customerOrders']) {
          OrderCustomer order = OrderCustomer(
            ID: element['ID'],
            PharmacyID: element['PharmacyID'],
            OrderNum: element['OrderNum'],
            OrderDate: element['OrderDate'],
            DeliveryPrice: element['DeliveryPrice'],
            OrderStatus: element['OrderStatus'],
            TotalPrice: element['TotalPrice'],
            CusAdd: element['customer']['Address'],
            Cusname: element['customer']['FullName'],
            Cusphone: element['customer']['PhoneNum'],
            pharmacy: Pharmacy.fromjson(element['pharmacy']),
          );

          List<Medicine> medicines = [];
          for (var detail in element['customerOrderDetails']) {
            Medicine medicine = Medicine(
              id: detail['medicine']['ID'],
              MedicineName: detail['medicine']['MedicineName'],
              MedicineDetails: detail['medicine']['MedicineDetails'],
              ProductionDate: detail['medicine']['ProductionDate'],
              ExpireDate: detail['medicine']['ExpireDate'],
            );
            medicines.add(medicine);
          }

          // Add medicines to the order
          order.medicines = medicines;

          listordercustomer.add(order);
          notifyListeners();
        }
        isLoadinggetallordercutomer = false;
        notifyListeners();
      } else {
        isLoadinggetallordercutomer = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      isLoadinggetallordercutomer = false;
      notifyListeners();
    }
  }

  Future<void> getallOrderPharmacyfromdelivery() async {
    isLoadinggetallorderpharmacy = true;
    notifyListeners();
    listorderpharmacy = [];
    notifyListeners();
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt("DeleiveryID");

    try {
      response = await http.get(
        Uri.parse('$baseURL${AppApi.GetAllDeliveryOrder(id!)}'),
        headers: {
          'Accept': 'application/json',
        },
      );

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        for (var element in data['pharmacyOrders']) {
          OrderPharmacy order = OrderPharmacy(
              ID: element['ID'],
              PharmacyID: element['PharmacyID'],
              OrderNum: element['OrderNum'],
              OrderDate: element['OrderDate'],
              DeliveryPrice: element['DeliveryPrice'],
              OrderStatus: element['OrderStatus'],
              TotalPrice: element['TotalPrice'],
              pharmacy: Pharmacy.fromjson(element['pharmacy']),
              warehouse: Warehouse.fromJson(element['warehouse']));

          List<Medicine> medicines = [];
          for (var detail in element['pharmacyOrderDetails']) {
            Medicine medicine = Medicine(
              id: detail['medicine']['ID'],
              MedicineName: detail['medicine']['MedicineName'],
              MedicineDetails: detail['medicine']['MedicineDetails'],
              ProductionDate: detail['medicine']['ProductionDate'],
              ExpireDate: detail['medicine']['ExpireDate'],
            );
            medicines.add(medicine);
          }

          // Add medicines to the order
          order.medicines = medicines;

          listorderpharmacy.add(order);
          notifyListeners();
        }
        isLoadinggetallorderpharmacy = false;
        notifyListeners();
      } else {
        isLoadinggetallorderpharmacy = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      isLoadinggetallorderpharmacy = false;
      notifyListeners();
    }
  }
}

import 'dart:convert';
import 'dart:math';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:v_pharma/Model/Cart.dart';
import 'package:v_pharma/Model/Medicine.dart';
import 'package:v_pharma/Model/Order.dart';
import 'package:v_pharma/constant/API-Url.dart';

class CartProvider extends ChangeNotifier {
  bool isLoadingplaceorder = false;
  bool isLoadinggetallorder = false;
  List<CartItem> cartItems = [];
  CartItem cartItem = CartItem();
  List<Order> listorder = [];
  Order oreder = Order();
  int? idpharma;

  void addToCart(Medicine item, BuildContext? context) {
    print(item.id);

    if (idpharma == null) {
      idpharma = item.PharmacyID;
      bool s = cartItems
          .where((element) => element.medicine!.id == item.id)
          .isNotEmpty;
      if (s) {
        print(cartItem.medicine!.id);

        var s =
            cartItems.firstWhere((element) => element.medicine!.id == item.id);
        s.updatequan();
        Flushbar(
          message: "Added To Cart",
          duration: Duration(seconds: 1),
        ).show(context!);
      } else {
        cartItem = CartItem(medicine: item, quan: 1);
        // print(cartItem.medicine!.id);
        cartItems.add(cartItem);
        notifyListeners();
        Flushbar(
          message: "Added To Cart",
          duration: Duration(seconds: 1),
        ).show(context!);

        notifyListeners();
      }
    } else if (item.PharmacyID == idpharma) {
      bool s = cartItems
          .where((element) => element.medicine!.id == item.id)
          .isNotEmpty;
      print(s);
      print(cartItems.map((e) => e.medicine!.id));

      if (s) {
        var s =
            cartItems.firstWhere((element) => element.medicine!.id == item.id);
        s.updatequan();
        notifyListeners();
        Flushbar(
          message: "Added To Cart",
          duration: Duration(seconds: 1),
        ).show(context!);
      } else {
        cartItem = CartItem(medicine: item, quan: 1);
        cartItems.add(cartItem);
        notifyListeners();
        print(cartItems.map((e) => e.medicine!.id));

        Flushbar(
          message: "Added To Cart",
          duration: Duration(seconds: 1),
        ).show(context!);

        notifyListeners();
      }
    } else {
      Flushbar(
        message: "You cannot add medicines from multiple pharmacies",
        duration: Duration(seconds: 1),
      ).show(context!);
    }
  }

  void removeFromCart(CartItem item) {
    cartItems.remove(item);
    if (cartItems.isEmpty) {
      idpharma = null;
    }
    notifyListeners();
  }

  double get totalPrice {
    double totalPrice = 0;
    for (var cartItem in cartItems) {
      if (cartItem.medicine != null && cartItem.quan != null) {
        totalPrice += cartItem.medicine!.Price! * cartItem.quan!;
      }
    }
    return totalPrice;
  }

  Future<bool> sendordershop({
    String? address,
    String? pharmaid,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt("idCustomer");
    isLoadingplaceorder = true;
    notifyListeners();

    List<Map<String, dynamic>> medicinelist = [];
    cartItems.forEach((cartitem) {
      medicinelist.add(cartitem.toJson());
    });
    print(medicinelist);
    Map<String, dynamic> requestBody = {
      "pharmacy_id": pharmaid,
      "customer_id": id,
      "delivery_price": "8000",
      "total_price": totalPrice,
      "address": address,
      "medicines_order": medicinelist,
    };

    String jsonString = json.encode(requestBody);
    // print(jsonString);
    http.Response response;
    try {
      response = await http.post(Uri.parse('$baseURL${AppApi.PlaceOrder}'),
          headers: {
            'Accept': 'application/json',
          },
          body: jsonString);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 201) {
        isLoadingplaceorder = false;
        notifyListeners();
        cartItems.clear();
        cartItem = CartItem();
        idpharma = null;
        return true;
      } else {
        isLoadingplaceorder = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      isLoadingplaceorder = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> getallOrderfromuser() async {
    isLoadinggetallorder = true;
    notifyListeners();
    listorder = [];
    notifyListeners();
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt("iduser");

    try {
      response = await http.get(
        Uri.parse('$baseURL${AppApi.GetAllCustomerOrder(id!)}'),
        headers: {
          'Accept': 'application/json',
        },
      );

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        for (var element in data['customerOrders']) {
          oreder = Order(
            DeliveryPrice: element['DeliveryPrice'],
            ID: element['ID'],
            OrderDate: element['OrderDate'],
            OrderNum: element['OrderNum'],
            OrderStatus: element['OrderStatus'],
            PharmacyID: element['PharmacyID'],
            TotalPrice: element['TotalPrice'],
          );
          listorder.add(oreder);
          notifyListeners();
        }
        isLoadinggetallorder = false;
        notifyListeners();
      } else {
        isLoadinggetallorder = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      isLoadinggetallorder = false;
      notifyListeners();
    }
  }
}

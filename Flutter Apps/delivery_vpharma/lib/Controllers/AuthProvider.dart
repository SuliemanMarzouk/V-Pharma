import 'dart:convert';

import 'package:delivery_vpharma/main.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:delivery_vpharma/Model/User.dart';
import 'package:delivery_vpharma/View/Customer/HomePage.dart';
import 'package:delivery_vpharma/constant/API-Url.dart';

class AuthProvider with ChangeNotifier {
  User user = User();
  bool isloadinglogin = false;
  bool isloadingsignup = false;
  bool isloadingupdateprofile = false;

  Future<bool> login({
    String? email,
    String? password,
    BuildContext? context,
  }) async {
    isloadinglogin = true;
    notifyListeners();
    print(email);
    print(password);
    http.Response response;
    try {
      response = await http.post(
        Uri.parse('$baseURL${AppApi.LOGIN}'),
        headers: {'Accept': 'application/json'},
        body: {
          'email': email,
          'password': password,
        },
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        user = User.fromJson(data);
        saveUser(user);

        isloadinglogin = false;
        notifyListeners();
        Navigator.pushAndRemoveUntil(
            context!,
            PageTransition(child: HomePage(), type: PageTransitionType.fade),
            (route) => false);
        return true;
      } else {
        isloadinglogin = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      isloadinglogin = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    removeuser();
  }

  Future<bool> updateacyivate({int? status}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt("DeleiveryID");

    try {
      response = await http.put(
        Uri.parse('$baseURL${AppApi.UpdateStatus(id!)}'),
        headers: {
          'Accept': 'application/json',
        },
        body: {"status": status!.toString()},
      );

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        dynamic date = jsonDecode(response.body);
        user.status = await date['delivery']['status'] == "1" ? true : false;
        notifyListeners();
        await prefs.setBool(
            'status', date['delivery']['status'] == "1" ? true : false);

        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);

      notifyListeners();
      return false;
    }
  }

  Future<void> getUser() async {
    SharedPreferences? preferences = await SharedPreferences.getInstance();

    user = User(
      DeleiveryID: await preferences.getInt('DeleiveryID'),
      FullName: await preferences.getString('FullName'),
      status: await preferences.getBool('status'),
    );
    notifyListeners();
  }

  Future<void> changestatus(bool status) async {
    SharedPreferences? preferences = await SharedPreferences.getInstance();

    user = User(
      status: status,
    );
    notifyListeners();
  }

  saveUser(User usershared) async {
    SharedPreferences? preferences = await SharedPreferences.getInstance();
    await preferences.setInt('DeleiveryID', usershared.DeleiveryID!);
    await preferences.setString('FullName', usershared.FullName!);
    await preferences.setBool("status", usershared.status!);
    await preferences.setBool("isLogged", true);
    debugPrint("Login Successfuly");
  }

  removeuser() async {
    SharedPreferences? preferences = await SharedPreferences.getInstance();
    await preferences.remove('DeleiveryID');
    await preferences.remove('FullName');
    await preferences.remove("isLogged");

    user = User();
    debugPrint("Logout Successfuly");
  }
}

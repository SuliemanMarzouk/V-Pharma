import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:v_pharma/Model/User.dart';
import 'package:v_pharma/View/Customer/HomePage.dart';
import 'package:v_pharma/constant/API-Url.dart';

class AuthProvider with ChangeNotifier {
  User user = User();
  bool isloadinglogin = false;
  bool isloadingsignup = false;
  bool isloadingupdateprofile = false;
  bool isloadingresetpassword = false;

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

  Future<bool> Signup({
    String? email,
    String? password,
    String? name,
    String? Birthdate,
    String? Gender,
    String? PhoneNum,
    String? Address,
    String? FullName,
    String? NationNum,
  }) async {
    // String? token = await servicesProvider.gettoken();
    isloadingsignup = true;
    http.Response response;

    try {
      var headers = {
        // 'Authorization': 'Bearer $token'
      };
      response =
          await http.post(Uri.parse('$baseURL${AppApi.SIGNUP}'), headers: {
        'Accept': 'application/json',
      }, body: {
        'name': name!,
        'email': email!,
        'password': password!,
        'NationNum': NationNum!,
        'FullName': FullName!,
        'Address': Address!,
        'PhoneNum': PhoneNum!,
        'Gender': Gender!,
        'Birthdate': Birthdate!,
      });

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 201) {
        isloadingsignup = false;
        notifyListeners();
        return true;
      } else {
        isloadingsignup = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      isloadingsignup = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    removeuser();
  }

  Future<bool> ResetPassword({
    dynamic currentpassword,
    dynamic newpassword,
  }) async {
    isloadingresetpassword = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt("iduser");
    try {
      var request = http.Request(
          'PUT', Uri.parse('$baseURL${AppApi.ResetPassword(id!)}'));
      request.bodyFields = {
        'current_password': currentpassword,
        'new_password': newpassword
      };

      http.StreamedResponse response = await request.send();
      print(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        isloadingresetpassword = false;
        notifyListeners();
        return true;
      } else {
        isloadingresetpassword = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      isloadingresetpassword = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> UpdateProfile({
    dynamic Address,
    dynamic PhoneNum,
  }) async {
    isloadingupdateprofile = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt("iduser");
    http.Response response;
    try {
      response = await http.put(
        Uri.parse('$baseURL${AppApi.UpdateProfile(id!)}'),
        headers: {'Accept': 'application/json'},
        body: {
          'Address': Address!,
          'PhoneNum': PhoneNum!,
        },
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        user = User.fromJson(data);
        saveUser(user);

        isloadingupdateprofile = false;
        notifyListeners();
        return true;
      } else {
        isloadingupdateprofile = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      isloadingupdateprofile = false;
      notifyListeners();
      return false;
    }
  }

  Future<User> getUser() async {
    SharedPreferences? preferences = await SharedPreferences.getInstance();

    user = User(
        Address: await preferences.getString('Address'),
        PhoneNum: await preferences.getString('PhoneNum'),
        Birthdate: await preferences.getString('Birthdate'),
        FullName: await preferences.getString('FullName'),
        Gender: await preferences.getString('Gender'),
        NationNum: await preferences.getString('NationNum'),
        email: await preferences.getString('email'),
        Customerid: await preferences.getInt('idCustomer'),
        id: await preferences.getInt('iduser'));

    return user;
  }

  saveUser(User usershared) async {
    SharedPreferences? preferences = await SharedPreferences.getInstance();
    await preferences.setInt('iduser', usershared.id!);
    await preferences.setInt('idCustomer', usershared.Customerid!);
    notifyListeners();
    await preferences.setString('Address', usershared.Address!.toString());
    await preferences.setString('Birthdate', usershared.Birthdate!.toString());
    await preferences.setString('FullName', usershared.FullName!.toString());
    await preferences.setString('NationNum', usershared.NationNum!.toString());
    await preferences.setString('Gender', usershared.Gender!.toString());
    await preferences.setString('email', usershared.email!.toString());
    await preferences.setString('PhoneNum', usershared.PhoneNum!.toString());
    await preferences.setBool("isLogged", true);
  }

  removeuser() async {
    SharedPreferences? preferences = await SharedPreferences.getInstance();
    await preferences.remove('Address');
    await preferences.remove('PhoneNum');
    await preferences.remove('idCustomer');
    await preferences.remove('iduser');
    await preferences.remove("isLogged");

    user = User();
    debugPrint("Logout Successfuly");
  }
}

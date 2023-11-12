import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_pharma/Controllers/AuthProvider.dart';
import 'package:v_pharma/Controllers/CartProvider.dart';
import 'package:v_pharma/Controllers/PharmacyMedicineProvider.dart';
import 'package:v_pharma/Splash.dart';
import 'package:v_pharma/constant/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool isLogged = preferences.getBool("isLogged") ?? false;
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<PharmacyMedicineProvider>(
          create: (context) => PharmacyMedicineProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
      ],
      child: MyApp(
        isLogged: isLogged,
      )));
}

AuthProvider authprovider = AuthProvider();
PharmacyMedicineProvider pharmacyMedicineProvider = PharmacyMedicineProvider();
CartProvider cartProvider = CartProvider();

class MyApp extends StatelessWidget {
  bool? isLogged;

  MyApp({this.isLogged});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'V-Pharma',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: kPrimarycolor,
        backgroundColor: kBaseColor,
        inputDecorationTheme: InputDecorationTheme(iconColor: kPrimarycolor),
        scaffoldBackgroundColor: kBaseColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => kPrimarycolor))),
        appBarTheme: AppBarTheme(backgroundColor: kPrimarycolor),
        iconTheme: IconThemeData(
          color: kPrimarycolor,
        ),
      ),
      home: Splash(
        isLogged: isLogged,
      ),
    );
  }
}

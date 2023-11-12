import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_vpharma/View/Auth/Login.dart';
import 'package:delivery_vpharma/constant/colors.dart';
import 'package:delivery_vpharma/main.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:delivery_vpharma/View/Customer/HomePage.dart';

class Splash extends StatefulWidget {
  bool? isLogged;

  Splash({this.isLogged});
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5)).then((value) async {
      if (widget.isLogged!) {
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(child: HomePage(), type: PageTransitionType.fade),
            (route) => false);
      } else {
        Navigator.pushReplacement(
          context,
          PageTransition(
            child: Login(),
            type: PageTransitionType.fade,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
            child: Image.asset('images/Splash.png', fit: BoxFit.cover),
          ),
          SafeArea(
            child: Align(
              alignment: AlignmentDirectional.center,
              child: SizedBox(
                width: width * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      "Welcome to",
                      style: TextStyle(
                          color: kBaseSecondryColor,
                          fontSize: 26,
                          fontWeight: FontWeight.w400),
                    ),
                    AutoSizeText(
                      "V / Pharma",
                      style: TextStyle(
                          color: kPrimarycolor,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    Align(
                      alignment: AlignmentDirectional.center,
                      child: SizedBox(
                        width: width * 0.9,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('images/splash1.png'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

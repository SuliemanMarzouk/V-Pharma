import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';
import 'package:v_pharma/View/Auth/Login.dart';
import 'package:v_pharma/View/Auth/Register1.dart';
import 'package:v_pharma/View/Customer/HomePage.dart';
import 'package:v_pharma/constant/colors.dart';
import 'package:v_pharma/constant/fonts.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

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
          ListView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Align(
                alignment: AlignmentDirectional.center,
                child: SizedBox(
                  width: width * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/splash1.png'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    AutoSizeText(
                      "Let's Get Started...",
                      style: TextStyle(
                        color: kBaseSecondryColor,
                        fontSize: 18,
                      ),
                    ),
                    Divider(
                      color: Colors.transparent,
                      height: height * .08,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                            child: Register1(),
                            type: PageTransitionType.fade,
                          ),
                          (route) => false,
                        );
                      },
                      child: Center(
                        child: Container(
                          width: width * .8,
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color:
                                    kBaseSecondryColor, // red as border color
                              ),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: AutoSizeText(
                                    "Continue with Create an account",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                                AutoSizeText(
                                  "@",
                                  style: TextStyle(
                                      color: kPrimarycolor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    Center(
                        child: TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageTransition(
                                child: HomePage(),
                                type: PageTransitionType.fade),
                            (route) => false);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Login as a ',
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                  offset: Offset(0, 5),
                                  blurRadius: 15,
                                  color: Colors.black.withAlpha(50))
                            ],
                            fontSize: 18,
                            color: kBaseSecondryColor,
                            decoration: TextDecoration.underline,
                          ),
                          children: [
                            TextSpan(
                              text: 'visitor',
                              style: TextStyle(
                                fontSize: 18,
                                decorationColor: kPrimarycolor,
                                decoration: TextDecoration.underline,
                                color:
                                    kPrimarycolor, // Set the primary color here
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                    Divider(
                      color: Colors.transparent,
                      height: height * .05,
                    ),
                    Center(
                      child: SizedBox(
                        width: width * .6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                "Already have an account? ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,

                                  color:
                                      kBaseSecondryColor, // Set the primary color here
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: Login(),
                                        type: PageTransitionType.fade));
                              },
                              child: AutoSizeText(
                                "Login",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      kPrimarycolor, // Set the primary color here
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

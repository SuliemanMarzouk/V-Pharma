import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';
import 'package:v_pharma/View/Auth/Login.dart';
import 'package:v_pharma/View/Auth/Register2.dart';
import 'package:v_pharma/constant/colors.dart';
import 'package:v_pharma/widgets/textinputall.dart';

class Register1 extends StatefulWidget {
  @override
  State<Register1> createState() => _Register1State();
}

class _Register1State extends State<Register1> {
  final emailsignupController = TextEditingController();
  final fullnamesignupController = TextEditingController();
  final idnumsignupController = TextEditingController();
  final phonenumbersignupController = TextEditingController();

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: height,
              width: width,
              child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Colors.grey.withOpacity(0.4), BlendMode.dstATop),
                  child: Image.asset('images/heximage.jpg', fit: BoxFit.cover)),
            ),
            SafeArea(
              child: Align(
                alignment: AlignmentDirectional.center,
                child: SizedBox(
                  width: width * 0.9,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Register",
                              style: TextStyle(
                                  color: kPrimarycolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Create an ',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: kBaseSecondryColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'account ',
                                    style: TextStyle(
                                      fontSize: 18,
                                      decorationColor: kPrimarycolor,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          kPrimarycolor, // Set the primary color here
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'to access all the features of ',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color:
                                          kBaseSecondryColor, // Set the primary color here
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'V / Pharma ',
                                    style: TextStyle(
                                      fontSize: 18,
                                      decorationColor: kPrimarycolor,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          kBaseSecondryColor, // Set the primary color here
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Full Name",
                            style: TextStyle(
                                color: kBaseSecondryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          Divider(
                            color: Colors.transparent,
                            height: 5,
                          ),
                          TextInpuAll(
                            isPassword: false,
                            label: "Ex. wessam alnono",
                            controller: fullnamesignupController,
                            prefixicon: Icons.person_outline_outlined,
                          ),
                          Divider(
                            color: Colors.transparent,
                          ),
                          Text(
                            "Your ID",
                            style: TextStyle(
                                color: kBaseSecondryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          Divider(
                            color: Colors.transparent,
                            height: 5,
                          ),
                          TextInpuAll(
                            isPassword: false,
                            label: "Your ID",
                            type: TextInputType.number,
                            controller: idnumsignupController,
                            prefixicon: CupertinoIcons.person_crop_rectangle,
                          ),
                          Divider(
                            color: Colors.transparent,
                          ),
                          Text(
                            "Email",
                            style: TextStyle(
                                color: kBaseSecondryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          Divider(
                            color: Colors.transparent,
                            height: 5,
                          ),
                          TextInpuAll(
                            isPassword: false,
                            label: "Ex: abc@example.com",
                            type: TextInputType.emailAddress,
                            controller: emailsignupController,
                            prefixicon: Icons.alternate_email,
                          ),
                          Divider(
                            color: Colors.transparent,
                          ),
                          Text(
                            "Your number",
                            style: TextStyle(
                                color: kBaseSecondryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          Divider(
                            color: Colors.transparent,
                            height: 5,
                          ),
                          TextInpuAll(
                            isPassword: false,
                            controller: phonenumbersignupController,
                            type: TextInputType.phone,
                            label: "EX: 0565655625",
                            prefixicon: CupertinoIcons.phone,
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.transparent,
                        height: height * .1,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: Register2(
                                      email: emailsignupController.text,
                                      fullname: fullnamesignupController.text,
                                      id: idnumsignupController.text,
                                      phone: phonenumbersignupController.text),
                                  type: PageTransitionType.fade));
                        },
                        child: Container(
                            height: height * .08,
                            decoration: BoxDecoration(
                                color: kPrimarycolor,
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                                child: Text(
                              "Next Step",
                              style: TextStyle(
                                  color: kBaseColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ))),
                      ),
                      // Divider(
                      //   color: Colors.transparent,
                      // ),
                      // Divider(
                      //   color: kBaseSecondryColor,
                      //   thickness: 2,
                      // ),
                      Divider(
                        color: Colors.transparent,
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
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    PageTransition(
                                        child: Login(),
                                        type: PageTransitionType.fade),
                                    (route) => false,
                                  );
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

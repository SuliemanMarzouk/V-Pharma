import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:v_pharma/Controllers/AuthProvider.dart';
import 'package:v_pharma/View/Auth/Login.dart';
import 'package:v_pharma/View/Customer/HomePage.dart';
import 'package:v_pharma/constant/colors.dart';
import 'package:v_pharma/main.dart';
import 'package:v_pharma/widgets/textinputall.dart';

class Register2 extends StatefulWidget {
  String? fullname;
  String? phone;
  String? email;
  String? id;
  Register2({this.email, this.fullname, this.id, this.phone});

  @override
  State<Register2> createState() => _Register2State();
}

final birthdaysignupController = TextEditingController();

class _Register2State extends State<Register2> {
  final addresssignupController = TextEditingController();
  final gendersignupController = TextEditingController();
  final passwordsignupController = TextEditingController();
  String selectedGender = '';

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    authprovider = Provider.of<AuthProvider>(context);

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
                            "The Address",
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
                            controller: addresssignupController,
                            label: "Ex. wessam alnono",
                            prefixicon: Icons.location_on_outlined,
                          ),
                          Divider(
                            color: Colors.transparent,
                          ),
                          Text(
                            "Choose Gender",
                            style: TextStyle(
                                color: kBaseSecondryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          Divider(
                            color: Colors.transparent,
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedGender =
                                        'M'; // حفظ القيمة "Male" عند الاختيار
                                  });
                                },
                                child: Container(
                                  width: width * 0.42,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.blue),
                                    color: selectedGender == 'M'
                                        ? Colors.blue
                                        : Colors.transparent,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text("Male")),
                                  ),
                                ),
                              ),
                              VerticalDivider(
                                color: Colors.transparent,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedGender =
                                        'F'; // حفظ القيمة "Female" عند الاختيار
                                  });
                                },
                                child: Container(
                                  width: width * 0.42,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.pink),
                                    color: selectedGender == 'F'
                                        ? Colors.pink
                                        : Colors.transparent,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text("Female")),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Divider(
                            color: Colors.transparent,
                          ),
                          Text(
                            "Date Of Birth",
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
                            controller: birthdaysignupController,
                            type: TextInputType.datetime,
                            label: "Date Of Birth",
                            prefixicon: Icons.alternate_email,
                          ),
                          Divider(
                            color: Colors.transparent,
                          ),
                          Text(
                            "Your Password",
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
                            isPassword: true,
                            controller: passwordsignupController,
                            label: "Password",
                            prefixicon: Icons.lock_outlined,
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.transparent,
                        height: height * .1,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (await authprovider.Signup(
                              name: widget.fullname,
                              email: widget.email,
                              Address: addresssignupController.text,
                              Birthdate: birthdaysignupController.text,
                              FullName: widget.fullname,
                              Gender: selectedGender,
                              NationNum: widget.id,
                              PhoneNum: widget.phone,
                              password: passwordsignupController.text)) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.scale,
                              title: "The account has been created",
                              desc: "You can now login",
                              btnOkOnPress: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    PageTransition(
                                        child: Login(),
                                        type: PageTransitionType.fade),
                                    (route) => false);
                              },
                              btnOkText: "Done",
                            ).show();
                          } else {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.scale,
                              title: "Error",
                              desc:
                                  "An unexpected error occurred. Please try again later",
                              btnOkOnPress: () {},
                              btnOkText: "Try Again",
                            ).show();
                          }
                        },
                        child: authprovider.isloadingsignup
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: kPrimarycolor,
                                ),
                              )
                            : Container(
                                height: height * .08,
                                decoration: BoxDecoration(
                                    color: kPrimarycolor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                    child: Text(
                                  "Register",
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

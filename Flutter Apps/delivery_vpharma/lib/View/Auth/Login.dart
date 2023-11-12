import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:delivery_vpharma/Controllers/AuthProvider.dart';
import 'package:delivery_vpharma/constant/colors.dart';
import 'package:delivery_vpharma/main.dart';
import 'package:delivery_vpharma/widgets/textinputall.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailloginController = TextEditingController();
  final passwordloginController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    emailloginController.clear();
    passwordloginController.clear();
    super.dispose();
  }

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
                              "Login",
                              style: TextStyle(
                                  color: kPrimarycolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35),
                            ),
                            Text(
                              "Sign in now to keep track of all your health issues",
                              style: TextStyle(
                                  color: kBaseSecondryColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
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
                            "Email",
                            style: TextStyle(
                                color: kBaseSecondryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          TextInpuAll(
                            isPassword: false,
                            label: "Ex: abc@example.com",
                            controller: emailloginController,
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
                          TextInpuAll(
                            isPassword: true,
                            label: "Your Password",
                            controller: passwordloginController,
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
                          if (await authprovider.login(
                              email: emailloginController.text,
                              password: passwordloginController.text,
                              context: context)) {
                          } else {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.scale,
                              title: "Error",
                              desc:
                                  "An unexpected error occurred. Please try again later",
                              btnOkOnPress: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  PageTransition(
                                      child: Login(),
                                      type: PageTransitionType.fade),
                                  (route) => false,
                                );
                              },
                              btnOkText: "Try Again",
                            ).show();
                          }
                        },
                        child: authprovider.isloadinglogin
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
                                  "Login",
                                  style: TextStyle(
                                      color: kBaseColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ))),
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      Divider(
                        color: kBaseSecondryColor,
                        thickness: 2,
                      ),
                      Divider(
                        color: Colors.transparent,
                        height: height * .1,
                      ),
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

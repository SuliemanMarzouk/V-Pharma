import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:v_pharma/Controllers/AuthProvider.dart';
import 'package:v_pharma/View/Auth/Login.dart';
import 'package:v_pharma/constant/colors.dart';
import 'package:v_pharma/main.dart';

import '../../widgets/textinputall.dart';

final newpasswordController = TextEditingController();
final confirmpasswordController = TextEditingController();
final formkey = GlobalKey<FormState>();

class ResetPassword extends StatefulWidget {
  ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  void dispose() {
    confirmpasswordController.clear();
    newpasswordController.clear();
    currentpasswordController.clear();
    super.dispose();
  }

  final currentpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    authprovider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Reset password"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            Image.asset("images/Resetpassword.png"),
            Text(
              "Current Password",
              style: TextStyle(
                  color: kBaseSecondryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            TextInpuAll(
              isPassword: true,
              label: "Current Password",
              controller: currentpasswordController,
              prefixicon: Icons.password,
            ),
            Divider(
              color: Colors.transparent,
            ),
            Divider(
              color: Colors.transparent,
            ),
            Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "New Password",
                    style: TextStyle(
                        color: kBaseSecondryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  TextInpuAll(
                    isPassword: true,
                    label: "New Password",
                    controller: newpasswordController,
                    prefixicon: Icons.password,
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),
                  Text(
                    "Confirm Password",
                    style: TextStyle(
                        color: kBaseSecondryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  TextInpuAll(
                    isPassword: true,
                    label: "Confirm Password",
                    controller: confirmpasswordController,
                    prefixicon: Icons.password,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            if (await authprovider.ResetPassword(
                                currentpassword: currentpasswordController.text,
                                newpassword: newpasswordController.text)) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.scale,
                                title: "The Password has been updated",
                                desc: "Please Login again",
                                btnOkOnPress: () {
                                  authprovider.logout();
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
                          }
                        },
                        child: authprovider.isloadingresetpassword
                            ? CircularProgressIndicator(
                                color: kBaseColor,
                              )
                            : Text("Reset Password"))),
              ],
            )
          ],
        ),
      ),
    );
  }
}

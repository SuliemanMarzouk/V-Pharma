import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:v_pharma/Controllers/AuthProvider.dart';
import 'package:v_pharma/Model/User.dart';
import 'package:v_pharma/View/Customer/ResetPassword.dart';
import 'package:v_pharma/constant/colors.dart';
import 'package:v_pharma/main.dart';
import 'package:v_pharma/widgets/textinputall.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final addressProfileController = TextEditingController();
  final genderProfileController = TextEditingController();
  final emailProfileController = TextEditingController();
  final fullnameProfileController = TextEditingController();
  final idnumProfileController = TextEditingController();
  final phonenumberProfileController = TextEditingController();
  User? user;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      user = await authprovider.getUser();
      phonenumberProfileController.text = user!.PhoneNum.toString();
      addressProfileController.text = user!.Address.toString();
      idnumProfileController.text = user!.NationNum.toString();
      emailProfileController.text = user!.email.toString();
      fullnameProfileController.text = user!.FullName.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authprovider = Provider.of<AuthProvider>(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 150,
              child: Image.asset('images/profile.png'),
            ),
            Text(
              "Phone Number",
              style: TextStyle(
                  color: kBaseSecondryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            TextInpuAll(
              isPassword: false,
              label: "Ex: abc@example.com",
              controller: phonenumberProfileController,
              prefixicon: Icons.phone,
            ),
            Divider(
              color: Colors.transparent,
            ),
            Text(
              "Address",
              style: TextStyle(
                  color: kBaseSecondryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            TextInpuAll(
              isPassword: false,
              label: "Ex: abc@example.com",
              controller: addressProfileController,
              prefixicon: Icons.location_on_sharp,
            ),
            Divider(
              color: Colors.transparent,
            ),
            Text(
              "Birthday",
              style: TextStyle(
                  color: kBaseSecondryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: kPrimarycolor, width: 2),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(Icons.calendar_month),
                  ),
                  Text("${authprovider.user.Birthdate}"),
                ],
              ),
            ),
            Divider(
              color: Colors.transparent,
            ),
            Text(
              "Full Name",
              style: TextStyle(
                  color: kBaseSecondryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: kPrimarycolor, width: 2),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(Icons.person),
                  ),
                  Text("${authprovider.user.FullName}"),
                ],
              ),
            ),
            Divider(
              color: Colors.transparent,
            ),
            Text(
              "Gender",
              style: TextStyle(
                  color: kBaseSecondryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: kPrimarycolor, width: 2),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(Icons.female),
                  ),
                  Text("${authprovider.user.Gender}"),
                ],
              ),
            ),
            Divider(
              color: Colors.transparent,
            ),
            Text(
              "NationNum",
              style: TextStyle(
                  color: kBaseSecondryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: kPrimarycolor, width: 2),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(Icons.numbers),
                  ),
                  Text("${authprovider.user.NationNum}"),
                ],
              ),
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
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: kPrimarycolor, width: 2),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(Icons.mail),
                  ),
                  Text("${authprovider.user.email}"),
                ],
              ),
            ),
            Divider(
              color: Colors.transparent,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: ResetPassword(),
                              type: PageTransitionType.fade));
                    },
                    child: Text("Reset Password"),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.transparent,
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () async {
                          if (await authprovider.UpdateProfile(
                            Address: addressProfileController.text,
                            PhoneNum: phonenumberProfileController.text,
                          )) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.scale,
                              title: "The Profile has been updated",
                              desc: "",
                              btnOkOnPress: () {},
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
                        child: authprovider.isloadingupdateprofile
                            ? CircularProgressIndicator(
                                color: kBaseColor,
                              )
                            : Text("Save"))),
              ],
            )
          ],
        ),
      ),
    );
  }
}

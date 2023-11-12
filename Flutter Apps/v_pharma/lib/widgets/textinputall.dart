import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v_pharma/View/Auth/Register2.dart';
import 'package:v_pharma/View/Customer/ResetPassword.dart';
import 'package:v_pharma/constant/colors.dart';
import 'package:intl/intl.dart';

class TextInpuAll extends StatefulWidget {
  TextEditingController? controller;
  String? label;
  bool? isPassword = false;
  TextInputType? type;
  IconData? prefixicon;
  IconData? suffixicon;
  TextInpuAll(
      {this.controller,
      this.isPassword,
      this.label,
      this.prefixicon,
      this.suffixicon,
      this.type});

  @override
  State<TextInpuAll> createState() => _TextInpuAllState();
}

class _TextInpuAllState extends State<TextInpuAll> {
  bool security = true;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          primaryColor: kPrimarycolor,
          colorScheme: ColorScheme.light(primary: kPrimarycolor)),
      child: TextFormField(
        maxLength: widget.label == "Your ID"
            ? 11
            : widget.label == "EX: 0565655625"
                ? 10
                : null,
        controller: widget.controller,
        cursorColor: kPrimarycolor,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Required field";
          } else if (widget.label == "Email address") {
            if (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value)) {
              return "Please enter a valid email";
            }
          } else if (widget.label == "Confirm Password") {
            if (newpasswordController.text != confirmpasswordController.text) {
              return "Not match";
            } else {
              return null;
            }
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIconColor: kPrimarycolor,
          prefixIcon: Icon(widget.prefixicon),
          suffix: widget.label == "Date Of Birth"
              ? IconButton(
                  icon: Icon(CupertinoIcons.calendar),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1960),
                      lastDate: DateTime.now(),
                    ).then((value) {
                      birthdaysignupController.text =
                          DateFormat('yyyyy-MM-dd').format(value!);
                    });
                  },
                )
              : null,

          labelStyle: TextStyle(fontSize: 14),
          hintText: widget.label!,
          hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.grey[500],
              fontStyle: FontStyle.italic),
          // label: AutoSizeText(
          //   widget.label!,
          //   minFontSize: 14,
          //   maxFontSize: 18,
          //   style: TextStyle(
          //     fontWeight: FontWeight.w400,
          //     color: Colors.grey[500],
          //   ),
          // ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: kPrimarycolor, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 2, color: kPrimarycolor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 2, color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        obscureText: widget.isPassword! ? security : false,
      ),
    );
  }
}

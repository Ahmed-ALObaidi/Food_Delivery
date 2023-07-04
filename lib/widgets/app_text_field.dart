import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimentions.dart';
import 'app_icon.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData prefixIcon;
  final Color iconColor;
  bool isObscure;
  AppTextField({Key? key, this.isObscure = false ,required this.textController, required this.hintText, required this.prefixIcon, required this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimentions.width10,right: Dimentions.width10,),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimentions.radius20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                spreadRadius: 1,
                offset: Offset(1, 1),
                color: Colors.grey.withOpacity(0.2))
          ]),
      child: TextField(
        // obscureText: hintText == 'Password' ? true : false,
        obscureText: isObscure,
        controller: textController,
        decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: AppIcon(
              iconData: prefixIcon,backGroundColor: Colors.white,size: Dimentions.height20,
              iconSize: Dimentions.iconSize25,
              iconColor: iconColor,
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimentions.radius20),
                borderSide: BorderSide(color: Colors.white, width: 1.0)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimentions.radius20),
                borderSide: BorderSide(color: Colors.white, width: 1.0)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimentions.radius20),
            )),
      ),
    );
  }
}

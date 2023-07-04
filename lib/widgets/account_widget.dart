import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimentions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/text_widget.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  TextWidget textWidget;

  AccountWidget({Key? key, required this.appIcon, required this.textWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          blurRadius: 2,
          offset: Offset(0, 4),
          color: Colors.grey.withOpacity(0.2),
        ),
      ],borderRadius: BorderRadius.circular(Dimentions.radius20)),
      padding: EdgeInsets.only(
          left: Dimentions.width20,
          top: Dimentions.height10,
          bottom: Dimentions.height10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appIcon,
          SizedBox(
            width: Dimentions.width20,
          ),
          textWidget
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimentions.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimentions.height100,
        width: Dimentions.width100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimentions.radius40),
            color: AppColors.mainColor),
        child: CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }
}

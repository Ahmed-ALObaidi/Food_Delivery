import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/text_widget.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message,
    {bool isError = true, String title = 'Error'}) {
  Get.snackbar(title, message,
      titleText: TextWidget(
        text: title,
        color: Colors.white,
      ),
      messageText: TextWidget(
        text: message,
        color: Colors.white,
      ),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      backgroundColor: title == "Perfect"  ?AppColors.mainColor :  Colors.redAccent );
}

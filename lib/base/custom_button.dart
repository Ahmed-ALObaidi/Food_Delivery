import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimentions.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double radius;
  final IconData? icon;

  const CustomButton(
      {Key? key,
      this.onPressed,
      required this.buttonText,
      this.transparent = false,
      this.margin,
      this.height,
      this.width,
      this.fontSize,
      this.radius = 5,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle = TextButton.styleFrom(
        backgroundColor: onPressed == null
            ? Theme.of(context).disabledColor
            : transparent
                ? Colors.transparent
                : AppColors.mainColor,
        minimumSize: Size(width != null ? width! : Dimentions.screenWidth,
            height != null ? height! : Dimentions.height45),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius)));
    return Center(
      child: SizedBox(
        width: width ?? Dimentions.screenWidth,
        height: height ?? Dimentions.screenHeight,
        child: TextButton(
          onPressed: onPressed,
          style: buttonStyle,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null
                  ? Padding(
                      padding: EdgeInsets.only(right: Dimentions.width5),
                      child: Icon(
                        icon,
                        color: transparent
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).cardColor,
                      ),
                    )
                  : SizedBox(),
              Text(
                buttonText,
                style: TextStyle(
                  fontSize: fontSize ?? Dimentions.font16,
                  color: transparent
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).cardColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

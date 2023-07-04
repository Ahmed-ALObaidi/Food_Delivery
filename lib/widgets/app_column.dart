import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/text_widget.dart';

import '../utils/colors.dart';
import '../utils/dimentions.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final double fontSize;
  const AppColumn({Key? key, required this.text, required this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: text,
          color: AppColors.mainBlackColor,
          fontSize: fontSize,
        ),
        SizedBox(
          height: Dimentions.sizedBox_10_height,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              children: List.generate(
                  5,
                      (index) => Icon(
                    Icons.star,
                    color: AppColors.mainColor,
                    size: Dimentions.sizedBox_15_height,
                  )),
            ),
            TextWidget(
                text: '4.5',
                color: AppColors.textColor,
                fontSize: Dimentions.font12),
            TextWidget(
                text: '1275',
                color: AppColors.textColor,
                fontSize: Dimentions.font12),
            TextWidget(
                text: 'comments',
                color: AppColors.textColor,
                fontSize: Dimentions.font12),
          ],
        ),
        SizedBox(
          height: Dimentions.sizedBox_5_height,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
                iconData: Icons.circle_sharp,
                text: 'Normal',
                textColor: AppColors.textColor,
                iconColor: AppColors.iconColor1),
            IconAndTextWidget(
                iconData: Icons.location_on,
                text: '1.7km',
                textColor: AppColors.textColor,
                iconColor: AppColors.mainColor),
            IconAndTextWidget(
                iconData: Icons.access_time_rounded,
                text: '35 min',
                textColor: AppColors.textColor,
                iconColor: AppColors.iconColor2),
          ],
        )
      ],
    );
  }
}

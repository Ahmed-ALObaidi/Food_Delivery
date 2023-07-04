import 'package:flutter/cupertino.dart';
import 'package:food_delivery/widgets/text_widget.dart';

import '../utils/dimentions.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Color textColor;
  final Color iconColor;

  const IconAndTextWidget(
      {Key? key,
      required this.iconData,
      required this.text,
      required this.textColor,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: iconColor,
          size: Dimentions.iconSize25,
        ),
        SizedBox(
          width: Dimentions.width5,
        ),
        TextWidget(
          text: text,
          color: textColor,
          fontSize: Dimentions.font12
        )
      ],
    );
  }
}

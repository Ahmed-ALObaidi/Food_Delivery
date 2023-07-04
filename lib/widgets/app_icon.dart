import 'package:flutter/cupertino.dart';

class AppIcon extends StatelessWidget {
  final IconData iconData;
  final Color backGroundColor;
  final double size;
  final double iconSize;
  final Color iconColor;

  AppIcon({
    Key? key,
    required this.iconData,
    this.backGroundColor = const Color(0xfffcf4e4),
    this.size = 40,
    this.iconColor = const Color(0xff756d54),
    required this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          color: backGroundColor.withOpacity(0.8)),
      child: Icon(iconData,color: iconColor,size: iconSize,),
    );
  }
}

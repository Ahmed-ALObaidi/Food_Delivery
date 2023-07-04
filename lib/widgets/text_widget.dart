import 'package:flutter/cupertino.dart';
import 'package:food_delivery/utils/dimentions.dart';

class TextWidget extends StatelessWidget {
  final String text;

  Color color;
  double fontSize;

  FontWeight fontWeight;
  int maxLine;

  TextAlign textAlign;
  TextOverflow textOverflow;

  double height;

  TextWidget({
    this.text = '',
    this.textOverflow = TextOverflow.ellipsis,
    this.color = const Color(0xff89dad0),
    this.fontWeight = FontWeight.normal,
    this.fontSize = 0,
    this.maxLine=1,
    this.textAlign = TextAlign.center,
    this.height=1.6,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine==1? 1 : maxLine,
      style: TextStyle(
          color: color,
          height: height==1.6 ? 1.6 : height,
          fontSize: fontSize== 0 ? Dimentions.font20 : fontSize,
          fontWeight: fontWeight,
          overflow: textOverflow,
          fontFamily: 'Roboto'
      ),
      textAlign: textAlign,
    );
  }
}

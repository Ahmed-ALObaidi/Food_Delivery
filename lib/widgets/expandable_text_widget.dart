import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimentions.dart';
import 'package:food_delivery/widgets/text_widget.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;

  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;
  double textHeight = Dimentions.height100;
  bool hiddenText = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
      print(textHeight);
      print(firstHalf.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? TextWidget(
        // height: 1.8,
        textAlign: TextAlign.start,
        maxLine: 1000,
        text: firstHalf,
              fontSize: Dimentions.font16,
        color: AppColors.paraColor,
            )
          : Column(
              children: [
                TextWidget(
                  // height: 1.8,
                  textAlign: TextAlign.start,
                  maxLine: 1000,
                  text: hiddenText
                      ? '${firstHalf}...'
                      : '${firstHalf+secondHalf}',
                  fontSize: Dimentions.font16,
                  color: AppColors.paraColor,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText=!hiddenText;
                    });
                    print(hiddenText);
                  },
                  child: Row(
                    children: [
                      TextWidget(
                        maxLine: 5,
                        text: 'Show more',
                        fontSize: Dimentions.font16,
                        color: AppColors.mainColor,
                      ),
                      Icon(
                        hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up,
                        color: AppColors.mainColor,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}

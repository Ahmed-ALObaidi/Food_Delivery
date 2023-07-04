import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  final String imgPath;
  final String text;

  const NoDataPage(
      {Key? key,
      this.imgPath = 'assets/image/empty_cart.png',
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
        ),
        Image.asset(
          imgPath,
          height: MediaQuery.of(context).size.height * 0.22,
          width: MediaQuery.of(context).size.width * 0.22,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Text(
          text,
          style: TextStyle(
              color: Theme.of(context).disabledColor,
              fontSize: MediaQuery.of(context).size.height * 0.0175,),textAlign: TextAlign.center,
        )
      ],
    );
  }
}

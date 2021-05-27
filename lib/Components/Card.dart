import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final press;
  final double fontsize;
  final Color colorCircle, textColor;
  final double buttonSize;
  final Icon icon;
  final String description;

  const CardButton(
      {required this.press,
      required this.colorCircle,
      required this.textColor,
      required this.buttonSize,
      required this.icon,
      required this.fontsize,
      required this.description});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        child: TextButton(
      onPressed: press,
      child: SizedBox(
        width: width - 60,
        height: height * (17 / 100),
        child: DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(23),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ]),
            child: Row(
              children: [],
            )),
      ),
    ));
  }
}

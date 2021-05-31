import 'package:flutter/material.dart';

class TextKT extends StatelessWidget {
  final String text;

  const TextKT({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        padding: EdgeInsets.only(left: 25, top: 15, bottom: 15),
        width: width,
        child: Text(
          text,
          style: TextStyle(
              fontFamily: 'supermarket',
              fontSize: 17,
              fontWeight: FontWeight.w500),
        ));
  }
}

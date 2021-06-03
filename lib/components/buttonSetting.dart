import 'package:flutter/material.dart';
import 'package:dekcare_frontend/components/constants.dart';

class ButtonSetting extends StatelessWidget {
  final icon, text, onPressed;

  ButtonSetting({this.icon, this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return TextButton(
      onPressed: onPressed,
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        width: width * 0.9,
        height: height * 0.075,
        child: DecoratedBox(
            child: Row(
              children: [
                Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Icon(
                      icon,
                      color: blackSecondaryFont,
                    )),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      text,
                      style: TextStyle(fontSize: 17, color: blackSecondaryFont),
                    ),
                  ),
                ]),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 2),
                ),
              ],
            )),
        color: whitePrimary,
      ),
    );
  }
}

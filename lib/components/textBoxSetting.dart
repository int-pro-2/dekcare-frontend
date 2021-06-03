import 'package:flutter/material.dart';
import 'package:dekcare_frontend/components/constants.dart';

class TextBoxSetting extends StatelessWidget {
  final onPress;
  final title;
  final info;
  final color;

  TextBoxSetting({this.color, this.onPress, this.title, this.info});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: width * 0.9,
      height: height * 0.075,
      child: Container(
        child: Row(
          children: [
            Expanded(
                child: Container(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                title,
                style: TextStyle(fontSize: 17),
              ),
            )),
            Expanded(
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Container(
                  padding: EdgeInsets.only(right: 15),
                  child: Text(
                    info,
                    style: TextStyle(fontSize: 17, color: blackSecondaryFont),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
      color: whitePrimary,
    );
  }
}

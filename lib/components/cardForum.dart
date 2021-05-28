import 'package:dekcare_frontend/components/button.dart';
import 'package:flutter/material.dart';
import 'package:dekcare_frontend/components/constants.dart';

class CardForum extends StatelessWidget {
  final press, text, title;

  const CardForum({this.press, this.text, this.title});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return TextButton(
      onPressed: () {},
      child: Container(
        child: SizedBox(
          width: width * 0.95,
          // height: height * (25 / 100),
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
              child: Column(
                children: [
                  SizedBox(height: height * 0.02),
                  Container(
                    padding: EdgeInsets.only(left: 20, top: 10),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 23,
                          fontFamily: 'supermarket',
                          color: blackPrimaryFont,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      text,
                      style: TextStyle(
                          height: 1.3,
                          fontSize: 20,
                          fontFamily: 'supermarket',
                          color: blackPrimaryFont,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

import 'package:dekcare_frontend/components/button.dart';
import 'package:flutter/material.dart';
import 'package:dekcare_frontend/components/constants.dart';

class CardKid extends StatelessWidget {
  final press, text, title, image;

  const CardKid({this.press, this.text, this.title, this.image});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      // onPressed: () {},
      child: Container(
        child: Container(
          width: width * 0.425,
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
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'supermarket',
                          color: blackPrimaryFont,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                  Container(
                    height: 110,
                    width: 70,
                    child: CircleAvatar(
                      backgroundColor: greyPrimary,
                      backgroundImage: AssetImage('assets/images/$image.png'),
                    ),
                  ),
                  Container(
                      height: height * 0.045,
                      width: width * 0.35,
                      child: Button(
                          color: yellowPrimary, onPress: press, title: text)),
                  SizedBox(
                    height: 10,
                  )
                ],
              )),
        ),
      ),
    );
  }
}

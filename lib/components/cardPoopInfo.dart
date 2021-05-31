import 'package:dekcare_frontend/components/button.dart';
import 'package:dekcare_frontend/components/text.dart';
import 'package:flutter/material.dart';
import 'package:dekcare_frontend/components/constants.dart';

class CardPoopInfo extends StatelessWidget {
  final press, text, title;

  const CardPoopInfo({this.press, this.text, this.title});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.9,
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
              SizedBox(height: height * 0.03),
              Container(
                padding: EdgeInsets.only(left: 20),
                width: width,
                child: Text(
                  '1 พฤษภาคม 2564',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                      width: 100,
                      child: CircleAvatar(
                        backgroundColor: yellowPrimary,
                      )),
                  Container(
                    padding: EdgeInsets.only(top: 20, right: 20),
                    child: Text(
                      'เหลว+เหลือง',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                      width: 100,
                      child: CircleAvatar(
                        backgroundColor: yellowPrimary,
                      )),
                  Container(
                    padding: EdgeInsets.only(top: 20, right: 20),
                    child: Text(
                      'เหลว+เหลือง',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              Container(
                  padding: EdgeInsets.only(left: 25, top: 15, bottom: 15),
                  width: width,
                  child: Text(
                    'อุจจาระลูกสุขภาพดี',
                    style: TextStyle(
                        fontFamily: 'supermarket',
                        fontSize: 20,
                        color: Colors.green[700],
                        fontWeight: FontWeight.w500),
                  ))
            ],
          )),
    );
  }
}

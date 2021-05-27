import 'package:flutter/material.dart';
import 'package:dekcare_frontend/Components/constants.dart';

class CardMoney extends StatelessWidget {
  final pressAddmoney, pressWithdraw, pressTransfer;
  final fontsize;
  final colorCircle, textColor;
  final buttonSize;
  final icon;

  const CardMoney({
    this.pressAddmoney,
    this.pressWithdraw,
    this.pressTransfer,
    this.colorCircle,
    this.textColor,
    this.buttonSize,
    this.icon,
    this.fontsize,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: SizedBox(
        width: width - 30,
        height: height * (25 / 100),
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
                Center(
                  child: Container(
                    height: height * 0.07,
                    width: width * 0.75,
                    child: Row(
                      children: [
                        Container(
                          width: width * 0.4,
                          child: Text(
                            'ยอดเงินคงเหลือ',
                            style: TextStyle(
                                fontFamily: 'supermarket', fontSize: 20),
                          ),
                        ),
                        Container(
                          width: width * 0.15,
                          child: SizedBox(
                            height: 10,
                          ),
                        ),
                        Container(
                          width: width * 0.2,
                          child: Text(
                            '400 Baht',
                            style: TextStyle(
                                fontFamily: 'supermarket', fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: width * 0.8,
                  child: Divider(
                    height: 5,
                    thickness: 2,
                    indent: 10,
                    endIndent: 10,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 130,
                      width: 120,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.teal,
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontStyle: FontStyle.italic),
                        ),
                        onPressed: pressAddmoney,
                        child: Column(children: [
                          Container(
                            height: 90,
                            width: 70,
                            child: CircleAvatar(
                              backgroundColor: greyPrimary,
                            ),
                          ),
                          Text(
                            'เติมเงิน',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'supermarket',
                                color: blackPrimaryFont,
                                fontStyle: FontStyle.normal),
                          )
                        ]),
                      ),
                    ),
                    SizedBox(
                      height: 130,
                      width: 120,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.teal,
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontStyle: FontStyle.italic),
                        ),
                        onPressed: pressAddmoney,
                        child: Column(children: [
                          Container(
                            height: 90,
                            width: 70,
                            child: CircleAvatar(
                              backgroundColor: greyPrimary,
                            ),
                          ),
                          Text(
                            'ถอนเงิน',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'supermarket',
                                color: blackPrimaryFont,
                                fontStyle: FontStyle.normal),
                          )
                        ]),
                      ),
                    ),
                    SizedBox(
                      height: 130,
                      width: 120,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.teal,
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontStyle: FontStyle.italic),
                        ),
                        onPressed: pressAddmoney,
                        child: Column(children: [
                          Container(
                            height: 90,
                            width: 70,
                            child: CircleAvatar(
                              backgroundColor: greyPrimary,
                            ),
                          ),
                          Text(
                            'โอนเงิน',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'supermarket',
                                color: blackPrimaryFont,
                                fontStyle: FontStyle.normal),
                          )
                        ]),
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
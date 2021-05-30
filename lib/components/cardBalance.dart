import 'package:flutter/material.dart';
import 'package:dekcare_frontend/components/constants.dart';

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.only(left: 20),
                    height: height * 0.07,
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
                          width: width * 0.4,
                          child: Text(
                            '400 Baht',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: 'supermarket',
                              fontSize: 20,
                            ),
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
                    Container(
                      width: width * 0.3,
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
                    Container(
                      width: width * 0.3,
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
                    Container(
                      width: width * 0.3,
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
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

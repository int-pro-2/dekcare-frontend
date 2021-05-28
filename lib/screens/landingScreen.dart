import 'package:dekcare_frontend/components/navBar/nav.dart';
import 'package:dekcare_frontend/components/constants.dart';
import 'package:dekcare_frontend/components/cardBalance.dart';
import 'package:dekcare_frontend/components/card.dart';
import 'package:dekcare_frontend/screens/poopInputScreen.dart';
import 'package:dekcare_frontend/screens/settingScreen.dart';

import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    @override
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: greySecondary,
      bottomNavigationBar: Nav(
        currentIndex: 0,
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
              height: height * 0.35,
              child: SizedBox(
                  width: width,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                        color: yellowPrimary,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )),
                  ))),
          Positioned(
            height: height * 0.12,
            child: Container(
                width: width * 0.95,
                alignment: Alignment.center,
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Container(
                    width: 40,
                    child: TextButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.notifications,
                        color: whitePrimary,
                      ),
                    ),
                  ),
                  Container(
                    width: 30,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SettingScreen();
                            },
                          ),
                        );
                      },
                      child: Icon(
                        Icons.more_vert,
                        color: whitePrimary,
                      ),
                    ),
                  ),
                ])),
          ),
          Positioned(
            height: height * 0.3,
            child: Container(
                width: width,
                alignment: Alignment.center,
                child: Container(
                  width: width,
                  child: Row(
                    children: [
                      Container(
                        width: width * 0.25,
                        child: Container(
                          margin: EdgeInsets.only(left: 15),
                          height: 90,
                          child: CircleAvatar(
                            backgroundColor: whitePrimary,
                          ),
                        ),
                      ),
                      Container(
                        width: width * 0.05,
                      ),
                      Container(
                        height: height * 0.09,
                        child: Column(
                          children: [
                            Container(
                              width: width * 0.70,
                              child: Text(
                                'ยินดีต้อนรับสู่ DekCare',
                                style: TextStyle(
                                    fontFamily: 'supermarket',
                                    fontSize: 32,
                                    color: whitePrimary),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              width: width * 0.70,
                              child: Text(
                                'Wirawat Jaiarree',
                                style: TextStyle(
                                    fontFamily: 'supermarket',
                                    fontSize: 25,
                                    color: whitePrimary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Positioned(
            height: height * 0.72,
            child: Container(
              width: width,
              alignment: Alignment.center,
              child: CardMoney(
                fontsize: 10,
                textColor: yellowPrimary,
                pressAddmoney: () {
                  print('test');
                },
              ),
            ),
          ),
          Positioned(
            height: height * 1.08,
            child: Container(
                width: width * 0.5,
                alignment: Alignment.center,
                child: Text(
                  'ดูแลลูกน้อยกันเถอะ',
                  style: TextStyle(
                      fontFamily: 'supermarket',
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                )),
          ),
          Positioned(
            height: height * 1.4,
            child: Container(
              width: width,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    width: width * 0.47,
                    child: CardKid(
                      title: 'สุขภาพอุจจาระของลูก',
                      text: 'บันทึกข้อมูล',
                      press: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PoopInputScreen();
                            },
                          ),
                        );
                      },
                    )),
                SizedBox(
                  width: width * 0.02,
                ),
                Container(
                    width: width * 0.47,
                    child: CardKid(
                      title: 'ข้อมูลสุขภาพอุจจาระ',
                      text: 'ดูข้อมูล',
                      press: () {},
                    )),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: greySecondary,
          bottomNavigationBar: Nav(
            currentIndex: 0,
          ),
          body: Container(
            height: height,
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                    height: height * 0.25,
                    width: width,
                    // color: yellowPrimary,
                    child: SizedBox(
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: yellowPrimary,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 20),
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
                                  padding: EdgeInsets.only(top: 20),
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
                              ],
                            ),
                            Row(
                              children: [
                                Row(
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
                                    Column(
                                      children: [
                                        Container(
                                          width: width * 0.7,
                                          padding: EdgeInsets.only(left: 20),
                                          // width: width * 0.70,
                                          child: Text(
                                            'ยินดีต้อนรับสู่ DekCare',
                                            style: TextStyle(
                                                fontFamily: 'supermarket',
                                                fontSize: 30,
                                                color: whitePrimary),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 20),
                                          width: width * 0.70,
                                          child: Text(
                                            'Wirawat Jaiarree',
                                            style: TextStyle(
                                                fontFamily: 'supermarket',
                                                fontSize: 25,
                                                color: whitePrimary),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                CardMoney(),
                SizedBox(
                  height: 10,
                ),
                Container(
                    padding: EdgeInsets.all(20),
                    width: width,
                    child: Text(
                      'ดูแลลูกน้อยกันเถอะ',
                      style: TextStyle(
                          fontFamily: 'supermarket',
                          fontSize: 25,
                          fontWeight: FontWeight.w500),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: CardKid(
                        press: () {},
                        title: 'สุขภาพอุจจาระของลูก',
                        text: 'บันทึกข้อมูล',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: CardKid(
                        press: () {},
                        title: 'ข้อมูลสุขภาพอุจจาระ',
                        text: 'ดูข้อมูล',
                      ),
                    )
                  ],
                )
              ]),
            ),
          )),
    );
  }
}

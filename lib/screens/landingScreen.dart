import 'package:dekcare_frontend/components/navBar/nav.dart';

import 'package:dekcare_frontend/components/constants.dart';
import 'package:dekcare_frontend/components/cardBalance.dart';
import 'package:dekcare_frontend/components/card.dart';
import 'package:dekcare_frontend/provider/authenticateProvider.dart';
import 'package:dekcare_frontend/provider/forumProvider.dart';
import 'package:dekcare_frontend/screens/addMoney.dart';
import 'package:dekcare_frontend/screens/poopInfo.dart';
import 'package:dekcare_frontend/screens/poopInputScreen.dart';
import 'package:dekcare_frontend/screens/settingScreen.dart';
import 'package:dekcare_frontend/screens/splashScreen.dart';
import 'package:dekcare_frontend/screens/transferMoney.dart';
import 'package:dekcare_frontend/screens/withdrawMoney.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<LandingScreen> {
  Future<void> fetchUserProfile() async {
    try {
      await Provider.of<AuthenticateProvider>(context, listen: false)
          .fetchProfile();
    } catch (error) {}
  }

  @override
  void initState() {
    super.initState();

    fetchUserProfile();
  }

  Widget build(BuildContext context) {
    @override
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer<AuthenticateProvider>(builder: (context, authen, _) {
        final userProfile = authen.user;
        if (userProfile.firstname.length == 0) {
          return SplashScreen();
        }
        return Container(
          color: yellowPrimary,
          child: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: yellowPrimary,
                  toolbarHeight: 0,
                  elevation: 0,
                ),
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
                                  Container(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
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
                                                backgroundImage: NetworkImage(
                                                    userProfile.picture),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                width: width * 0.7,
                                                padding: const EdgeInsets.only(
                                                    left: 20),
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
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                width: width * 0.70,
                                                child: Text(
                                                  userProfile.firstname +
                                                      " " +
                                                      userProfile.lastname,
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
                      CardMoney(
                        money: userProfile.money.toString(),
                        pressTransfer: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return TransferMoneyScreen(userProfile.money);
                              },
                            ),
                          );
                        },
                        pressWithdraw: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return WithdrawMoneyScreen(userProfile.money);
                              },
                            ),
                          );
                        },
                        pressAddmoney: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return AddMoneyScreen();
                              },
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      !userProfile.isDoctor
                          ? Container(
                              padding: EdgeInsets.all(20),
                              width: width,
                              child: Text(
                                'ดูแลลูกน้อยกันเถอะ',
                                style: TextStyle(
                                    fontFamily: 'supermarket',
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500),
                              ))
                          : Container(),
                      !userProfile.isDoctor
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: CardKid(
                                    image: 'doctor1',
                                    press: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return PoopInputScreen();
                                          },
                                        ),
                                      );
                                    },
                                    title: 'สุขภาพอุจจาระของลูก',
                                    text: 'บันทึกข้อมูล',
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 20),
                                  child: CardKid(
                                    image: 'Doctor',
                                    press: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return PoopInfo();
                                          },
                                        ),
                                      );
                                    },
                                    title: 'ข้อมูลสุขภาพอุจจาระ',
                                    text: 'ดูข้อมูล',
                                  ),
                                )
                              ],
                            )
                          : Container()
                    ]),
                  ),
                )),
          ),
        );
      }),
    );
  }
}

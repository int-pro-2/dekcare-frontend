import 'package:dekcare_frontend/components/Toggle.dart';
import 'package:dekcare_frontend/components/constants.dart';
import 'package:dekcare_frontend/components/consult/consultCard.dart';
import 'package:dekcare_frontend/components/navBar/nav.dart';
import 'package:dekcare_frontend/components/topBar.dart';
import 'package:dekcare_frontend/components/searchBar.dart';
import 'package:flutter/material.dart';

import 'landingScreen.dart';

class ConsultScreen extends StatefulWidget {
  @override
  _ConsultState createState() => _ConsultState();
}

class _ConsultState extends State<ConsultScreen> {
  @override
  Widget build(BuildContext context) {
    @override
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
        theme: ThemeData(fontFamily: 'supermarket'),
        home: Scaffold(
          appBar: PreferredSize(
            child: TopBar(
              titleText: 'ปรึกษาลูกน้อยกับหมอ',
              enableBackButton: true,
              contextFromPage: context,
            ),
            preferredSize: Size.fromHeight((height * 0.075)),
          ),
          bottomNavigationBar: Nav(
            currentIndex: 1,
          ),
          backgroundColor: greySecondary,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    Toggle(button1Title: 'ค้นหาหมอ', button2Title: 'หมอติดดาว'),
                    Container(
                      width: width * 0.92,
                      child: searchBar(title: 'ค้นหาชื่อคุณหมอที่นี่'),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) => consultCard(
                        name: "นพ. วิรวรรธ ใจอารีย์",
                        profile:
                            "https://scontent.fkdt2-1.fna.fbcdn.net/v/t1.6435-9/53458185_2150818338340159_4143062862610300928_n.jpg?_nc_cat=100&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=TZrNhZRqI6MAX9Nv44L&_nc_ht=scontent.fkdt2-1.fna&oh=9e7fd4dc6eeb448b34a3576abd63698c&oe=60D970C9",
                        hospital: "โรงพยาบาลจุฬาลงกรณ์",
                        isFavorite: true,
                        press: () {
                          print('navigate');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return LandingScreen();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

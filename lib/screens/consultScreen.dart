import 'package:dekcare_frontend/components/Toggle.dart';
import 'package:dekcare_frontend/components/constants.dart';
import 'package:dekcare_frontend/components/consult/consultCard.dart';
import 'package:dekcare_frontend/components/navBar/nav.dart';
import 'package:dekcare_frontend/components/topBar.dart';
import 'package:dekcare_frontend/components/searchBar.dart';
import 'package:dekcare_frontend/provider/chatProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'landingScreen.dart';

class ConsultScreen extends StatefulWidget {
  @override
  _ConsultState createState() => _ConsultState();
}

class _ConsultState extends State<ConsultScreen> {
  void ListDoctor() async {
    try {
      await Provider.of<ChatProvider>(context).getListOfDoctor();
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ListDoctor();
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
                    Consumer<ChatProvider>(builder: (context, value, child) {
                      final doctorList = value.doctorList;
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: doctorList.length,
                          itemBuilder: (context, index) => consultCard(
                              name: doctorList[index].firstname +
                                  " " +
                                  doctorList[index].lastname,
                              profile: doctorList[index].picture,
                              hospital: doctorList[index].hospital,
                              isFavorite: doctorList[index].isFav,
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
                              }));
                    }),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

// ListView.builder(
// physics: NeverScrollableScrollPhysics(),
// shrinkWrap: true,
// itemCount: 3,
// itemBuilder: (context, index) => consultCard(
// name: doctorList[i].firstname +
//     " " +
//     doctorList[i].lastname,
// profile: doctorList[i].picture,
// hospital: doctorList[i].hospital,
// isFavorite: doctorList[i].isFav,
// press: () {
//   print('navigate');
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) {
//         return LandingScreen();
//       },
//     ),
//   );
// }))
// ),

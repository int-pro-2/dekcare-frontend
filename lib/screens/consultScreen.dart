import 'dart:ffi';

import 'package:dekcare_frontend/screens/individualChatScreen.dart';
import 'package:dekcare_frontend/components/Toggle.dart';
import 'package:dekcare_frontend/components/constants.dart';
import 'package:dekcare_frontend/components/consult/consultCard.dart';
import 'package:dekcare_frontend/components/navBar/nav.dart';
import 'package:dekcare_frontend/components/topBar.dart';
import 'package:dekcare_frontend/components/searchBar.dart';
import 'package:dekcare_frontend/provider/chatProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsultScreen extends StatefulWidget {
  bool fav = false;
  @override
  _ConsultState createState() => _ConsultState();
}

class _ConsultState extends State<ConsultScreen> {
  bool isLoading = true;

  void changeFav(newFav) {
    setState(() {
      widget.fav = newFav;
    });
    ListDoctor(widget.fav);
  }

  void ListDoctor(bool isFav) async {
    try {
      setState(() {
        isLoading = true;
      });
      print(isFav);
      await Provider.of<ChatProvider>(context, listen: false)
          .getListOfDoctor(isFav);
    } catch (err) {
      print(err);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    print(widget.fav);
    ListDoctor(widget.fav);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
                    Toggle(
                      button1Title: 'ค้นหาหมอ',
                      button2Title: 'หมอติดดาว',
                      current: widget.fav,
                      onChange: changeFav,
                    ),
                    Container(
                      width: width * 0.92,
                      child: searchBar(title: 'ค้นหาชื่อคุณหมอที่นี่'),
                    ),
                    Consumer<ChatProvider>(builder: (context, value, child) {
                      final doctorList = value.doctorList;
                      return isLoading
                          ? Container(
                              height: height * 0.6,
                              child: Center(
                                child: CircularProgressIndicator(
                                    color: yellowPrimary),
                              ),
                            )
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: doctorList.length,
                              itemBuilder: (context, index) => consultCard(
                                  id: doctorList[index].id,
                                  name: doctorList[index].firstname +
                                      " " +
                                      doctorList[index].lastname,
                                  profile: doctorList[index].picture,
                                  hospital: doctorList[index].hospital,
                                  isFavorite: doctorList[index].isFav,
                                  refresher: () {
                                    ListDoctor(widget.fav);
                                  },
                                  press: () {
                                    print('navigate');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return IndividualChatScreen(
                                            id: doctorList[index].id,
                                            name: doctorList[index].firstname +
                                                " " +
                                                doctorList[index].lastname,
                                            picture: doctorList[index].picture,
                                          );
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

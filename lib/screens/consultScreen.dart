import 'package:dekcare_frontend/Components/Toggle.dart';
import 'package:dekcare_frontend/Components/constants.dart';
import 'package:dekcare_frontend/Components/navBar/nav.dart';
import 'package:dekcare_frontend/Components/topBar.dart';
import 'package:dekcare_frontend/Components/searchBar.dart';
import 'package:flutter/material.dart';

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
                    searchBar(title: 'ค้นหาชื่อคุณหมอที่นี่'),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

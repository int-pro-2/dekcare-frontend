import 'package:dekcare_frontend/components/button.dart';
import 'package:dekcare_frontend/components/cardPoopInfo.dart';
import 'package:dekcare_frontend/components/constants.dart';
import 'package:dekcare_frontend/components/topBar.dart';
import 'package:dekcare_frontend/components/text.dart';
import 'package:flutter/material.dart';

class PoopInfo extends StatefulWidget {
  @override
  _PoopInfoState createState() => _PoopInfoState();
}

var color = '';
var type = '';

class _PoopInfoState extends State<PoopInfo> {
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      theme: ThemeData(fontFamily: 'supermarket'),
      home: SafeArea(
              child: Scaffold(
            backgroundColor: greySecondary,
            appBar: PreferredSize(
                child: TopBar(
                  press: () {
                    setState(() {
                      color = '';
                      type = '';
                    });
                  },
                  titleText: 'ข้อมูลสุขภาพอุจจาระของลูก',
                  enableBackButton: true,
                  contextFromPage: context,
                ),
                preferredSize: Size.fromHeight((height * 0.075))),
            body: Container(
              padding: EdgeInsets.all(20),
              width: width,
              height: height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CardPoopInfo(
                      title: 'test',
                      text: 'test',
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

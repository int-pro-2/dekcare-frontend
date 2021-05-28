import 'package:dekcare_frontend/components/navBar/nav.dart';
import 'package:dekcare_frontend/components/topBar.dart';
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
            preferredSize: Size.fromHeight(height * 0.075),
            child: TopBar(
              titleText: 'ปรึกษาลูกน้อยกับหมอ',
              enableBackButton: false,
            )),
        bottomNavigationBar: Nav(
          currentIndex: 1,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text('Consult')
          ],
        ),
      ),
    );
  }
}

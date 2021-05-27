import 'package:dekcare_frontend/Components/navBar/nav.dart';

import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    @override
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        bottomNavigationBar: Nav(
          currentIndex: 1,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text('setting')
          ],
        ));
  }
}

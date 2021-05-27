import 'package:dekcare_frontend/Components/navBar/nav.dart';
import 'package:dekcare_frontend/Components/constants.dart';

import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    @override
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        bottomNavigationBar: Nav(
          currentIndex: 0,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text('landing')
          ],
        ));
  }
}

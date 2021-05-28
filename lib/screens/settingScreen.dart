import 'package:dekcare_frontend/components/button.dart';
import 'package:dekcare_frontend/components/constants.dart';
import 'package:dekcare_frontend/components/navBar/nav.dart';
import 'package:dekcare_frontend/screens/loginScreen.dart';

import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    @override
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'setting',
            style: TextStyle(fontSize: 23),
          ),
          centerTitle: true,
          backgroundColor: yellowPrimary,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(30)))),
      body: Container(
        width: width,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              child: Button(
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
                title: 'Logout',
                color: yellowPrimary,
              ),
            )
          ],
        ),
      ),
    );
  }
}

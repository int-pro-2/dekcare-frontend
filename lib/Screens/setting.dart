import 'package:dekcare_frontend/Components/button.dart';
import 'package:dekcare_frontend/Components/constants.dart';
import 'package:dekcare_frontend/Components/navBar/nav.dart';
import 'package:dekcare_frontend/Screens/login.dart';

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
                          return Login();
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
        ));
  }
}

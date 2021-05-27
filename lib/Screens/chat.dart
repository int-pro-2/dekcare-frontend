import 'package:dekcare_frontend/Components/navBar/nav.dart';
import 'package:dekcare_frontend/Components/constants.dart';
import 'package:dekcare_frontend/Components/TopBar.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    @override
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
        theme: ThemeData(fontFamily: 'supermarket'),
        home: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(height * 0.1),
                child: TopBar(
                  titleText: 'สนทนา',
                  enableBackButton: true,
                )),
            bottomNavigationBar: Nav(
              currentIndex: 3,
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text('Chat')
              ],
            )));
  }
}

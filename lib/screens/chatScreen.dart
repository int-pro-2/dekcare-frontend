import 'package:dekcare_frontend/components/navBar/nav.dart';
import 'package:dekcare_frontend/components/constants.dart';
import 'package:dekcare_frontend/components/topBar.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<ChatScreen> {
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
        ),
      ),
    );
  }
}

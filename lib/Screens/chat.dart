import 'package:dekcare_frontend/Components/navBar/nav.dart';
import 'package:dekcare_frontend/Components/constants.dart';
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
            appBar: AppBar(
                title: const Text(
                  'ปรึกษาลูกน้อยกับหมอ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                backgroundColor: yellowPrimary,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(30)))),
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

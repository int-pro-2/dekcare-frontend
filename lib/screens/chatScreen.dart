import 'package:dekcare_frontend/Components/chat/chatPreviewCard.dart';
import 'package:dekcare_frontend/Components/navBar/nav.dart';
import 'package:dekcare_frontend/Components/constants.dart';
import 'package:dekcare_frontend/Components/topBar.dart';
import 'package:dekcare_frontend/Components/searchBar.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
        theme: ThemeData(fontFamily: 'supermarket'),
        home: Scaffold(
            appBar: PreferredSize(
                child: TopBar(
                  titleText: 'สนทนา',
                  enableBackButton: false,
                  contextFromPage: context,
                ),
                preferredSize: Size.fromHeight(height * 0.075)),
            bottomNavigationBar: Nav(
              currentIndex: 3,
            ),
            backgroundColor: greySecondary,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: width * 0.85,
                          child: searchBar(title: 'ค้นหาชื่อเพื่อน'),
                        ),
                      ),
                      chatPreviewCard(
                          name: "	นพ. วิรวรรธ ใจอารีย์",
                          profile: "/assets/images/doctorIcon.png",
                          message: "สวัสดีครับคนไข้")
                    ],
                  ),
                ),
              ),
            )));
  }
}

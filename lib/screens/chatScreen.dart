import 'package:dekcare_frontend/Screens/landingScreen.dart';
import 'package:dekcare_frontend/components/chat/chatPreviewCard.dart';
import 'package:dekcare_frontend/components/navBar/nav.dart';
import 'package:dekcare_frontend/components/constants.dart';
import 'package:dekcare_frontend/components/topBar.dart';
import 'package:dekcare_frontend/components/searchBar.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<ChatScreen> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
    return null;
  }

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
                      Container(
                        height: height * 0.7,
                        child: RefreshIndicator(
                          key: refreshKey,
                          onRefresh: refreshList,
                          child: SingleChildScrollView(
                            physics: ScrollPhysics(),
                            child: Column(children: [
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 100,
                                itemBuilder: (context, index) =>
                                    chatPreviewCard(
                                  name: "	นพ. วิรวรรธ ใจอารีย์",
                                  profile: "/assets/images/doctorIcon.png",
                                  message: "สวัสดีครับคนไข้",
                                  press: () {
                                    print('navigate');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return LandingScreen();
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}

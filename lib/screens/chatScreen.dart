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
                          width: width * 0.92,
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
                                itemCount: 5,
                                itemBuilder: (context, index) =>
                                    chatPreviewCard(
<<<<<<< HEAD
                                  name: "นพ. วิรวรรธ ใจอารีย์",
                                  profile:
                                      "https://scontent.fkdt2-1.fna.fbcdn.net/v/t1.6435-9/53458185_2150818338340159_4143062862610300928_n.jpg?_nc_cat=100&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=TZrNhZRqI6MAX9Nv44L&_nc_ht=scontent.fkdt2-1.fna&oh=9e7fd4dc6eeb448b34a3576abd63698c&oe=60D970C9",
=======
                                  name: "	นพ. วิรวรรธ ใจอารีย์",
                                  profile: "/doctorIcon.png",
>>>>>>> ed4f3b2dfa700fbdb1959434911fdcee8b4eb265
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

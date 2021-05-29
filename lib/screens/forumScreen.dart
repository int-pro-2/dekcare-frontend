import 'package:dekcare_frontend/components/cardForum.dart';
import 'package:dekcare_frontend/components/navBar/nav.dart';
import 'package:dekcare_frontend/Components/TopBar.dart';
import 'package:dekcare_frontend/Components/searchBar.dart';
import 'package:dekcare_frontend/screens/createForum.dart';
import 'package:dekcare_frontend/screens/forumInsideScreen.dart';
import 'package:flutter/material.dart';
import 'package:dekcare_frontend/Components/constants.dart';
import 'dart:async';
import 'dart:math';
import 'package:dekcare_frontend/provider/forumProvider.dart';
import 'package:provider/provider.dart';

class ForumScreen extends StatefulWidget {
  @override
  _ForumState createState() => _ForumState();
}

class Forum {
  final id;
  final ownwerID;
  final userName;
  final topic;
  final body;
  final date;
  final comment;
  final img;

  Forum(
      {this.id,
      this.ownwerID,
      this.topic,
      this.body,
      this.date,
      this.userName,
      this.comment,
      this.img});
}

class _ForumState extends State<ForumScreen> {
  List<Forum> forum = [
    Forum(
        id: '01',
        ownwerID: '8b36a2e7-a990',
        userName: 'กาต๊าก กะตัก',
        body:
            "ตอนนี้ลูกสาวอายุ 15 ค่ะ เป็นเด็กคิดเยอะ (คิดร้ายกับผู้อื่น คิดว่าผู้อื่นคิดร้ายกับตัว) ชอบเพ้อฝันค่ะ กลัวอายเพื่อน กลัวมีไม่เท่าเทียมกับเพื่อน เป็นเด็กอวดเก่งอวดดี แต่ทำในสิ่งที่ตัวเองอวดไม่ได้เลย จ้องจะมีปัญหากับคนอื่นเสมอ",
        date: '2021-05-28',
        topic: 'ปรึกษาเรื่องลูกหน่อยค่ะ เครียดมาก...??',
        comment: '4',
        img: 'null'),
    Forum(
        id: '02',
        ownwerID: '8b36a2e7-a990',
        userName: 'กาต๊าก กะตัก',
        body:
            "ตอนนี้ลูกสาวอายุ 15 ค่ะ เป็นเด็กคิดเยอะ (คิดร้ายกับผู้อื่น คิดว่าผู้อื่นคิดร้ายกับตัว) ชอบเพ้อฝันค่ะ กลัวอายเพื่อน กลัวมีไม่เท่าเทียมกับเพื่อน เป็นเด็กอวดเก่งอวดดี แต่ทำในสิ่งที่ตัวเองอวดไม่ได้เลย จ้องจะมีปัญหากับคนอื่นเสมอ",
        date: '2021-05-28',
        topic: 'ปรึกษาเรื่องลูกหน่อยค่ะ เครียดมาก...??',
        comment: '4',
        img: 'null'),
    Forum(
        id: '03',
        ownwerID: '8b36a2e7-a990',
        userName: 'กาต๊าก กะตัก',
        body:
            "ตอนนี้ลูกสาวอายุ 15 ค่ะ เป็นเด็กคิดเยอะ (คิดร้ายกับผู้อื่น คิดว่าผู้อื่นคิดร้ายกับตัว) ชอบเพ้อฝันค่ะ กลัวอายเพื่อน กลัวมีไม่เท่าเทียมกับเพื่อน เป็นเด็กอวดเก่งอวดดี แต่ทำในสิ่งที่ตัวเองอวดไม่ได้เลย จ้องจะมีปัญหากับคนอื่นเสมอ",
        date: '2021-05-28',
        topic: 'ปรึกษาเรื่องลูกหน่อยค่ะ เครียดมาก...??',
        comment: '4',
        img: 'null'),
    Forum(
        id: '04',
        ownwerID: '8b36a2e7-a990',
        userName: 'กาต๊าก กะตัก',
        body:
            "ตอนนี้ลูกสาวอายุ 15 ค่ะ เป็นเด็กคิดเยอะ (คิดร้ายกับผู้อื่น คิดว่าผู้อื่นคิดร้ายกับตัว) ชอบเพ้อฝันค่ะ กลัวอายเพื่อน กลัวมีไม่เท่าเทียมกับเพื่อน เป็นเด็กอวดเก่งอวดดี แต่ทำในสิ่งที่ตัวเองอวดไม่ได้เลย จ้องจะมีปัญหากับคนอื่นเสมอ",
        date: '2021-05-28',
        topic: 'ปรึกษาเรื่องลูกหน่อยค่ะ เครียดมาก...??',
        comment: '4',
        img: 'null'),
  ];

  var random;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  void initState() {
    super.initState();
    random = Random();
    refreshList();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));

    setState(() {});

    return null;
  }

  @override
  Widget build(BuildContext context) {
    @override
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'supermarket'),
      home: Scaffold(
        backgroundColor: greySecondary,
        appBar: PreferredSize(
            child: TopBar(titleText: 'กระทู้ถาม/ตอบ', enableBackButton: false),
            preferredSize: Size.fromHeight(height * 0.075)),
        bottomNavigationBar: Nav(
          currentIndex: 2,
        ),
        body: Container(
          height: height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 20, bottom: 20, left: 10),
                      width: width * 0.9,
                      child: searchBar(title: 'ค้นหาชื่อคุณหมอที่นี่'),
                    ),
                    Container(
                      width: width * 0.1,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return CreaetForumScreen();
                              },
                            ),
                          );
                        },
                        child: Icon(
                          Icons.add_comment,
                          color: yellowPrimary,
                        ),
                      ),
                    ),
                  ],
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
                          itemCount: forum.length,
                          itemBuilder: (context, index) => CardForum(
                            isComment: false,
                            title: forum[index].topic,
                            press: () {
                              print('navigate');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ForumInsideScreen();
                                  },
                                ),
                              );
                            },
                            isInside: false,
                            text: forum[index].body,
                            userName: forum[index].userName,
                            comment: forum[index].comment,
                          ),
                        ),
                      ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

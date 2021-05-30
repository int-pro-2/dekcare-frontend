import 'package:dekcare_frontend/components/cardForum.dart';
import 'package:dekcare_frontend/components/chatInput.dart';
import 'package:dekcare_frontend/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:dekcare_frontend/Components/constants.dart';
import 'dart:async';
import 'dart:math';
import 'package:dekcare_frontend/provider/forumProvider.dart';
import 'package:provider/provider.dart';
import 'package:dekcare_frontend/components/emptyItem.dart';

class ForumInsideScreen extends StatefulWidget {
  @override
  final index;

  ForumInsideScreen({
    this.index,
  });

  _ForumInsideScreenState createState() => _ForumInsideScreenState();
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

class Reply {
  final id;
  final ownwerID;
  final userName;
  final topic;
  final body;
  final date;
  final comment;
  final img;

  Reply(
      {this.id,
      this.ownwerID,
      this.topic,
      this.body,
      this.date,
      this.userName,
      this.comment,
      this.img});
}

class Comment {
  final id;
  final userID;
  final forumID;
  final userName;
  final commentID;
  final text;
  final date;
  final img;

  Comment(
      {this.id,
      this.userID,
      this.forumID,
      this.userName,
      this.commentID,
      this.text,
      this.date,
      this.img});
}

class _ForumInsideScreenState extends State<ForumInsideScreen> {
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
  ];
  List<Comment> comment = [
    // Comment(
    //     id: '01',
    //     userID: '8b36a2e7-a990',
    //     userName: 'บอยไง',
    //     commentID: '01',
    //     text:
    //         "เรามีเวลาเอาใจใส่เขาก่อนหน้านี้ มากพอไหม เขาขาดอะไรจากคนรอบข้างบ้างหรือเปล่า บางทีเราปล่อยเขามานานไม่ค่อยได้บอกกล่าวซึ่งมาถึงจุดนี้จะเปลี่ยนแปลงก็ต้องใช้เวลาบ้าง  บอกกล่าวกันด้วยเหตุผล ผลเสียต่างๆที่จะตามมา การใช้อารมณ์น่าจะทำให้สิ่งต่างๆยิ่งแย่ลงนะ ใจเย็นๆ บางทีก็ต้องคิดดูอีกทีว่าตัวเราหรือเปล่าที่ทำให้เขาเป็นแบบนี้ หรือเพราะตัวเขาเอง",
    //     date: '2021-05-28',
    //     img: 'null'),
    // Comment(
    //     id: '02',
    //     userID: '8b36a2e7-a990',
    //     userName: 'เต้ยเอง',
    //     commentID: '02',
    //     text: "เห็นด้วยกับความคิดเห็นแรกค่ะ",
    //     date: '2021-05-28',
    //     img: 'null'),
  ];

  void fetchForums() async {
    try {
      await Provider.of<ForumProvider>(context, listen: false)
          .fetchSpecificForum(widget.index);
    } catch (error) {}
  }

  var random;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  void initState() {
    fetchForums();

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
      home: Consumer<ForumProvider>(builder: (context1, forumProvider, _) {
        final forumList = forumProvider.specificforum;
        if (forumList.length == 0) {
          return SplashScreen();
        }

        print(forumList[0].comments.length);

        return Scaffold(
          backgroundColor: greySecondary,
          appBar: PreferredSize(
              child: AppBar(
                centerTitle: true,
                title: Text(
                  'กระทู้ถาม/ตอบ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                backgroundColor: yellowPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30)),
                ),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              preferredSize: Size.fromHeight(height * 0.075)),
          body: Container(
            height: height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: height * 0.9,
                    child: RefreshIndicator(
                      key: refreshKey,
                      onRefresh: refreshList,
                      child: SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child: Column(children: [
                          CardForum(
                            isInside: true,
                            url: forumList[0].picture,
                            isComment: false,
                            title: forumList[0].topic,
                            press: () {},
                            text: forumList[0].body,
                            userName: forumList[0].firstname,
                            date: forumList[0].date.toString().substring(0, 19),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(15),
                                width: width * 0.425,
                                child: Divider(
                                  height: 5,
                                  thickness: 2,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                              ),
                              Text('ความคิดเห็น',
                                  style: TextStyle(color: Colors.grey)),
                              Container(
                                padding: EdgeInsets.all(15),
                                width: width * 0.425,
                                child: Divider(
                                  height: 5,
                                  thickness: 2,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                              ),
                            ],
                          ),
                          if (forumList[0].comments.length != 0)
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: forumList[0].comments.length,
                              itemBuilder: (context, index) => CardForum(
                                commentID: (index + 1).toString(),
                                url: forumList[0].comments[index].picture,
                                isComment: true,
                                isInside: true,
                                text: forumList[0].comments[index].text,
                                userName:
                                    forumList[0].comments[index].firstname,
                              ),
                            ),
                          if (forumList[0].comments.length == 0)
                            EmptyList(text: 'ไม่มีความคิดเห็น'),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(15),
                                width: width * 0.425,
                                child: Divider(
                                  height: 5,
                                  thickness: 2,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                              ),
                              Text('ความคิดเห็น',
                                  style: TextStyle(color: Colors.grey)),
                              Container(
                                padding: EdgeInsets.all(15),
                                width: width * 0.425,
                                child: Divider(
                                  height: 5,
                                  thickness: 2,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: ChatInput(
                              isCreate: false,
                              hasShadow: true,
                              widthh: width * 0.95,
                              heightt: height * 0.1,
                              color: Colors.white,
                              title: 'แสดงความคิดเห็น....',
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ]),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

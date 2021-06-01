import 'package:dekcare_frontend/components/cardForum.dart';
import 'package:dekcare_frontend/components/constants.dart';
import 'package:dekcare_frontend/components/emptyItem.dart';
import 'package:dekcare_frontend/components/navBar/nav.dart';

import 'package:dekcare_frontend/Components/searchBar.dart';
import 'package:dekcare_frontend/screens/createForum.dart';
import 'package:dekcare_frontend/screens/forumInsideScreen.dart';
import 'package:dekcare_frontend/screens/splashScreen.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math';
import 'package:dekcare_frontend/provider/forumProvider.dart';
import 'package:provider/provider.dart';
import 'package:dekcare_frontend/components/pagination.dart';

class Forums {
  final int id;
  final String ownerID;
  final String displayname;
  final String topic;
  final String body;
  final DateTime date;
  final int count;
  final String picture;

  Forums(
      {required this.id,
      required this.ownerID,
      required this.topic,
      required this.body,
      required this.date,
      required this.displayname,
      required this.count,
      required this.picture});
}

class ForumScreen extends StatefulWidget {
  @override
  _ForumState createState() => _ForumState();
}

class _ForumState extends State<ForumScreen> {
  var random;
  var initList = 0;
  var pageRender;

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  void fetchForums() async {
    try {
      await Provider.of<ForumProvider>(context, listen: false).fetchForums();
    } catch (error) {}
  }

  List<Forums> listRender = [];

  void initState() {
    super.initState();
    random = Random();
    fetchForums();

    refreshList();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
    fetchForums();
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
      home: Consumer<ForumProvider>(builder: (context, forumProvider, _) {
        final forumList = forumProvider.forums;
        if (initList == 0 && forumList.length != 0) {
          initList++;
          for (var i = 0; i < 3; i++) {
            listRender.add(Forums(
                id: forumList[i].id,
                ownerID: forumList[i].ownerID,
                topic: forumList[i].topic,
                body: forumList[i].body,
                date: forumList[i].date,
                displayname: forumList[i].displayname,
                count: forumList[i].count,
                picture: forumList[i].picture));
          }
        }

        return SafeArea(
                  child: Scaffold(
            backgroundColor: greySecondary,
            appBar: PreferredSize(
                child: AppBar(
                  automaticallyImplyLeading: false,
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
                ),
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
                          child: searchBar(title: 'ค้นหากระทู้ที่นี่'),
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
                    listRender.length == 0
                        ? EmptyList(text: 'test')
                        : Container(
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
                                    itemCount: listRender.length,
                                    itemBuilder: (context, index) => CardForum(
                                      pressComment: () {},
                                      url: listRender[index].picture,
                                      isComment: false,
                                      title: listRender[index].topic,
                                      text: listRender[index].body,
                                      userName: listRender[index].displayname,
                                      comment: listRender[index].count,
                                      press: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return ForumInsideScreen(
                                                index: listRender[index].id,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      isInside: false,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Pagination(
                                      mode: 'simple',
                                      onChange: (page) {
                                        setState(() {
                                          pageRender = page;
                                        });
                                        print(pageRender);
                                        listRender = [];
                                        for (var i = ((pageRender - 1) * 3);
                                            i < pageRender * 3;
                                            i++) {
                                          if (i < forumList.length) {
                                            listRender.add(Forums(
                                                id: forumList[i].id,
                                                ownerID: forumList[i].ownerID,
                                                topic: forumList[i].topic,
                                                body: forumList[i].body,
                                                date: forumList[i].date,
                                                displayname:
                                                    forumList[i].displayname,
                                                count: forumList[i].count,
                                                picture: forumList[i].picture));
                                          }
                                        }
                                      },
                                      totalItems: forumList.length,
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
      }),
    );
  }
}

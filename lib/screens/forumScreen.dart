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

class _ForumState extends State<ForumScreen> {
  var random;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  void fetchForums() async {
    try {
      await Provider.of<ForumProvider>(context, listen: false).fetchForums();
    } catch (error) {}
  }

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

        return Scaffold(
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
                            itemCount: forumList.length,
                            itemBuilder: (context, index) => CardForum(
                              url: forumList[index].picture,
                              isComment: false,
                              title: forumList[index].topic,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ForumInsideScreen(
                                        index: forumList[index].id,
                                      );
                                    },
                                  ),
                                );
                              },
                              isInside: false,
                              text: forumList[index].body,
                              userName: forumList[index].displayname,
                              comment: forumList[index].count,
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
        );
      }),
    );
  }
}

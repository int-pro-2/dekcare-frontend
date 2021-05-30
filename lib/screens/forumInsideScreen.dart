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

class _ForumInsideScreenState extends State<ForumInsideScreen> {
  void fetchForums() async {
    try {
      await Provider.of<ForumProvider>(context, listen: false)
          .fetchSpecificForum(widget.index);
    } catch (error) {}
  }

  void createComment() async {
    print('create Forum');
    try {
      await Provider.of<ForumProvider>(context, listen: false).createComment(
          widget.index.toString(),
          commentController.text,
          DateTime.now().toString());
      fetchForums();
    } catch (error) {
      print(error);
    }
    print('done create forumm');
  }

  var isComment = '';
  var random;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  var refreshKey1 = GlobalKey<RefreshIndicatorState>();

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
    fetchForums();
    return null;
  }

  Future<Null> refreshList1() async {
    refreshKey1.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));

    setState(() {});
    fetchForums();
    return null;
  }

  @override
  final TextEditingController commentController = TextEditingController();

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
            child: RefreshIndicator(
                key: refreshKey,
                onRefresh: refreshList,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: height * 0.9,
                        child: RefreshIndicator(
                          key: refreshKey1,
                          onRefresh: refreshList1,
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
                                date: forumList[0]
                                    .date
                                    .toString()
                                    .substring(0, 19),
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
                              Row(children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: ChatInput(
                                    onchange: (text) {
                                      setState(() {
                                        isComment = text;
                                      });
                                    },
                                    controller: commentController,
                                    isCreate: false,
                                    hasShadow: true,
                                    widthh: width * 0.75,
                                    heightt: height * 0.07,
                                    color: Colors.white,
                                    title: 'แสดงความคิดเห็น....',
                                  ),
                                ),
                                Container(
                                  height: height * 0.07,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        if (isComment != '') {
                                          createComment();
                                          commentController.clear();
                                        }
                                        if (isComment == '') {
                                          print('comment is null');
                                        }
                                      },
                                      child: Icon(
                                        Icons.send,
                                        color: Colors.black54,
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  isComment == ''
                                                      ? Colors.grey
                                                      : Colors.amber[300]),
                                          shadowColor:
                                              MaterialStateProperty.all<Color>(
                                            Colors.transparent,
                                          ))),
                                ),
                              ]),
                              SizedBox(
                                height: 20,
                              )
                            ]),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        );
      }),
    );
  }
}

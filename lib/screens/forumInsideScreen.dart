import 'package:dekcare_frontend/components/cardForum.dart';
import 'package:dekcare_frontend/components/chatInput.dart';
import 'package:dekcare_frontend/screens/splashScreen.dart';
import 'package:flutter/foundation.dart';
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
  late FocusNode myFocusNode = FocusNode();

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

  void createReply(String commentID) async {
    print('create refly inside');
    try {
      await Provider.of<ForumProvider>(context, listen: false).createReply(
          commentID, commentController.text, DateTime.now().toString());
      fetchForums();
    } catch (error) {
      print(error);
    }
    print('done create reply');
  }

  var isComment = '';
  List isShow = [];
  List isShowReply = [];

  List isMatchReply = [];

  var countReply = 0;
  var random;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  var refreshKey1 = GlobalKey<RefreshIndicatorState>();

  void initState() {
    fetchForums();

    super.initState();
    myFocusNode = FocusNode();

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

  void test() {
    print('boy');
  }

  var commentID = 0;

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  final TextEditingController commentController = TextEditingController();
  final TextEditingController replyController = TextEditingController();

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
        } else {
          for (int i = 0; i < forumList[0].comments.length; i++) {
            isShow.add(false);
            isMatchReply.add(i);
          }
        }

        return Scaffold(
          resizeToAvoidBottomInset: true,
          // bottomNavigationBar:
          backgroundColor: greySecondary,
          appBar: PreferredSize(
              child: AppBar(
                centerTitle: true,
                title: Text(
                  '???????????????????????????/?????????',
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
          body: SafeArea(
            child: Container(
              height: height,
              child: RefreshIndicator(
                  key: refreshKey,
                  onRefresh: refreshList,
                  child: Column(children: [
                    Expanded(
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
                                      color: Colors.white,
                                      isInside: true,
                                      url: forumList[0].picture,
                                      isComment: false,
                                      title: forumList[0].topic,
                                      pressComment: test,
                                      hello: 'boyplus',
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
                                        Text('?????????????????????????????????',
                                            style:
                                                TextStyle(color: Colors.grey)),
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
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              forumList[0].comments.length,
                                          itemBuilder: (context, index) {
                                            var count = 0;
                                            return Column(children: [
                                              CardForum(
                                                commentorReply:
                                                    '?????????????????????????????????????????? ',
                                                color: Colors.white,
                                                isReply: true,
                                                controller: replyController,
                                                // myFocusNode: myFocusNode,
                                                press: () {},
                                                replypress: () {
                                                  print('inside');
                                                  setState(() {
                                                    commentID = forumList[0]
                                                        .comments[index]
                                                        .id;
                                                  });
                                                  myFocusNode.requestFocus();
                                                  commentController.text =
                                                      '@?????????????????????????????????????????? ' +
                                                          (index + 1)
                                                              .toString();
                                                },

                                                pressComment: () {
                                                  print('ha');
                                                  createReply(forumList[0]
                                                      .comments[index]
                                                      .id
                                                      .toString());
                                                  print(forumList[0]
                                                      .comments[index]
                                                      .id);
                                                },
                                                // date: forumList[0].comments[index].,
                                                commentID:
                                                    (index + 1).toString(),
                                                url: forumList[0]
                                                    .comments[index]
                                                    .picture,
                                                isComment: true,
                                                isInside: true,
                                                text: forumList[0]
                                                    .comments[index]
                                                    .text,
                                                userName: forumList[0]
                                                    .comments[index]
                                                    .firstname,
                                              ),
                                              if (isShow.length > 0)
                                                ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: forumList[0]
                                                        .comments[index]
                                                        .replies
                                                        .length,
                                                    itemBuilder:
                                                        (context, index1) {
                                                      if (forumList[0]
                                                              .comments[index]
                                                              .replies[index1]
                                                              .commentID ==
                                                          forumList[0]
                                                              .comments[index]
                                                              .id) count++;
                                                      if (count == 1)
                                                        return forumList[0]
                                                                    .comments[
                                                                        index]
                                                                    .replies[
                                                                        index1]
                                                                    .commentID ==
                                                                forumList[0]
                                                                    .comments[
                                                                        index]
                                                                    .id
                                                            ? TextButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    isShow[index] =
                                                                        !isShow[
                                                                            index];
                                                                  });
                                                                },
                                                                child: Text(
                                                                    '??????????????????????????????????????????????????????'))
                                                            : Container();
                                                      return Container();
                                                    }),
                                              if (isShow.length > 0)
                                                if (isShow[index] == true)
                                                  ListView.builder(
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: forumList[0]
                                                          .comments[index]
                                                          .replies
                                                          .length,
                                                      itemBuilder:
                                                          (context, index1) {
                                                        if (forumList[0]
                                                                .comments[index]
                                                                .replies[index1]
                                                                .commentID ==
                                                            forumList[0]
                                                                .comments[index]
                                                                .id)
                                                          return Column(
                                                              children: [
                                                                TextButton(
                                                                    onPressed:
                                                                        () {},
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          width,
                                                                      child:
                                                                          CardForum(
                                                                        commentorReply:
                                                                            '?????????????????????????????????????????????????????? ',
                                                                        color: Colors
                                                                            .grey[200],
                                                                        pressComment:
                                                                            () {},
                                                                        commentID:
                                                                            '',
                                                                        isReply:
                                                                            false,
                                                                        title:
                                                                            'title',
                                                                        date:
                                                                            'date',
                                                                        isComment:
                                                                            true,
                                                                        text: forumList[0]
                                                                            .comments[index]
                                                                            .replies[index1]
                                                                            .text,
                                                                        userName: forumList[0]
                                                                            .comments[index]
                                                                            .replies[index1]
                                                                            .firstname,
                                                                        url: forumList[0]
                                                                            .comments[index]
                                                                            .replies[index1]
                                                                            .picture,
                                                                        isInside:
                                                                            true,
                                                                        comment: forumList[0]
                                                                            .comments[index]
                                                                            .replies[index1]
                                                                            .picture,
                                                                      ),
                                                                    ))
                                                              ]);

                                                        return Container();
                                                      })
                                            ]);
                                          }),
                                    if (forumList[0].comments.length == 0)
                                      EmptyList(text: '????????????????????????????????????????????????'),
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
                                        Text('?????????????????????????????????',
                                            style:
                                                TextStyle(color: Colors.grey)),
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
                                    SizedBox(
                                      height: 140,
                                    )
                                  ]),
                                ),
                              ),
                            ),
                            // SizedBox(height: 100)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: height * 0.09,
                      color: whitePrimary,
                      child: Container(
                        color: Colors.grey[200],
                        child: Row(children: [
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
                              title: '?????????????????????????????????????????????....',
                              focusNode: myFocusNode,
                            ),
                          ),
                          Container(
                            width: width * 0.175,
                            height: height * 0.065,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (isComment != '' &&
                                      !commentController.text
                                          .contains('@??????????????????????????????????????????')) {
                                    createComment();
                                    commentController.clear();
                                  }
                                  if (isComment == '') {
                                    print('comment is null');
                                  }
                                  if (commentController.text
                                      .contains('@??????????????????????????????????????????')) {
                                    createReply(commentID.toString());
                                  }
                                  commentController.clear();
                                },
                                child: Icon(
                                  Icons.send,
                                  color: Colors.black54,
                                ),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        isComment == ''
                                            ? Colors.grey
                                            : Colors.amber[300]),
                                    shadowColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.transparent,
                                    ))),
                          ),
                        ]),
                      ),
                    ),
                  ])),
            ),
          ),
        );
      }),
    );
  }
}

import 'package:dekcare_frontend/screens/individualChatScreen.dart';
import 'package:dekcare_frontend/components/chat/chatPreviewCard.dart';
import 'package:dekcare_frontend/components/chat/emptyCard.dart';
import 'package:dekcare_frontend/components/navBar/nav.dart';
import 'package:dekcare_frontend/components/constants.dart';
import 'package:dekcare_frontend/components/topBar.dart';
import 'package:dekcare_frontend/components/searchBar.dart';
import 'package:dekcare_frontend/provider/chatProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainChatScreen extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<MainChatScreen> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  bool isLoading = true;

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));
    GetPreviewList();
    return null;
  }

  void GetPreviewList() async {
    try {
      setState(() {
        isLoading = true;
      });
      await Provider.of<ChatProvider>(context, listen: false)
          .getListOfChatPreview();
    } catch (err) {
      print(err);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    GetPreviewList();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'supermarket'),
        home: Scaffold(
            appBar: PreferredSize(
                child: TopBar(
                  titleText: 'สนทนา',
                  enableBackButton: false,
                  contextFromPage: context,
                ),
                preferredSize: Size.fromHeight(height * 0.075)),
            bottomNavigationBar: Nav(currentIndex: 3),
            backgroundColor: greySecondary,
            body: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                      child: Container(
                        width: width * 0.92,
                        child: searchBar(title: 'ค้นหาชื่อเพื่อน'),
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        key: refreshKey,
                        onRefresh: refreshList,
                        color: yellowPrimary,
                        child: SingleChildScrollView(
                          physics: ScrollPhysics(),
                          child: Column(children: [
                            Consumer<ChatProvider>(
                                builder: (context, value, child) {
                              final chatPreviewList = value.chatPreviewList;
                              return (chatPreviewList.length == 0
                                  ? EmptyCard(
                                      pevContext: context,
                                    )
                                  : isLoading
                                      ? Container(
                                          height: height * 0.6,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                                color: yellowPrimary),
                                          ),
                                        )
                                      : ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: chatPreviewList.length,
                                          itemBuilder: (context, index) =>
                                              chatPreviewCard(
                                            name: chatPreviewList[index]
                                                    .firstname +
                                                " " +
                                                chatPreviewList[index].lastname,
                                            profile:
                                                chatPreviewList[index].picture,
                                            message:
                                                chatPreviewList[index].message,
                                            press: () {
                                              print('navigate');
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return IndividualChatScreen(
                                                        id: chatPreviewList[
                                                                index]
                                                            .targetID,
                                                        name: chatPreviewList[
                                                                    index]
                                                                .firstname +
                                                            " " +
                                                            chatPreviewList[
                                                                    index]
                                                                .lastname,
                                                        picture:
                                                            chatPreviewList[
                                                                    index]
                                                                .picture);
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        ));
                            })
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}

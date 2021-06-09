import 'dart:async';
import 'package:dekcare_frontend/Screens/transferMoney.dart';
import 'package:dekcare_frontend/components/errorCard.dart';
import 'package:dekcare_frontend/provider/authenticateProvider.dart';
import 'package:dekcare_frontend/provider/forumProvider.dart';
import 'package:dekcare_frontend/screens/individualChatScreen.dart';
import 'package:dekcare_frontend/Screens/transferMoney.dart';
import 'package:dekcare_frontend/components/chat/chatPreviewCard.dart';
import 'package:dekcare_frontend/components/chat/emptyCard.dart';
import 'package:dekcare_frontend/components/navBar/nav.dart';
import 'package:dekcare_frontend/components/constants.dart';
import 'package:dekcare_frontend/components/topBar.dart';
import 'package:dekcare_frontend/provider/chatProvider.dart';
import 'package:dekcare_frontend/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainChatScreen extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<MainChatScreen> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  bool isLoading = true;
  bool privilege = false;

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));
    GetPreviewList();
    return null;
  }

  Future<void> GetPreviewList() async {
    try {
      await Provider.of<ChatProvider>(context, listen: false)
          .getListOfChatPreview();
    } catch (err) {
      print(err);
    }
  }

  Widget renderChatList(width, height, userProfile) {
    return Consumer<AuthenticateProvider>(builder: (context, authen, child) {
      return Consumer<ChatProvider>(builder: (context, value, child) {
        final chatPreviewList = value.chatPreviewList;
        return (authen.user.privilege
            ? chatPreviewList.length == 0
                ? EmptyCard(
                    pevContext: context,
                  )
                : isLoading
                    ? Container(
                        height: 120,
                        child: Center(
                          child: CircularProgressIndicator(
                              backgroundColor: yellowPrimary),
                        ),
                      )
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: chatPreviewList.length,
                        itemBuilder: (context, index) => chatPreviewCard(
                          name: chatPreviewList[index].firstname +
                              " " +
                              chatPreviewList[index].lastname,
                          profile: chatPreviewList[index].picture,
                          message: chatPreviewList[index].message,
                          press: () {
                            print('navigate');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return IndividualChatScreen(
                                      id: chatPreviewList[index].targetID,
                                      name: chatPreviewList[index].firstname +
                                          " " +
                                          chatPreviewList[index].lastname,
                                      picture: chatPreviewList[index].picture);
                                },
                              ),
                            );
                          },
                        ),
                      )
            : errorCard(
                width: width,
                height: height,
                page: TransferMoneyScreen(userProfile[0].money),
              ));
      });
    });
  }

  Future<void> fetchUserProfile() async {
    try {
      await Provider.of<AuthenticateProvider>(context, listen: false)
          .fetchProfile();
    } catch (error) {}
  }

  Future<void> fetchData() async {
    setState(() => isLoading = true);
    await GetPreviewList();
    await fetchUserProfile();
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'supermarket'),
      home: Consumer<AuthenticateProvider>(builder: (context, authen, child) {
        final isDoctor = authen.user.isDoctor;
        return Consumer<ForumProvider>(
          builder: (context, forumProvider, _) {
            final userProfile = forumProvider.userProfile;
            if (userProfile.length == 0) {
              return SplashScreen();
            }
            return Container(
              color: yellowPrimary,
              child: SafeArea(
                child: Scaffold(
                    appBar: PreferredSize(
                        child: TopBar(
                          titleText: 'สนทนา',
                          enableBackButton: false,
                          contextFromPage: context,
                        ),
                        preferredSize: Size.fromHeight(height * 0.075)),
                    bottomNavigationBar: Nav(currentIndex: isDoctor ? 2 : 3),
                    backgroundColor: greySecondary,
                    body: SafeArea(
                      child: Center(
                        child: Column(
                          children: [
                            Expanded(
                              child: RefreshIndicator(
                                key: refreshKey,
                                onRefresh: refreshList,
                                color: yellowPrimary,
                                child: SingleChildScrollView(
                                  physics: ScrollPhysics(),
                                  child: Column(children: [
                                    renderChatList(width, height, userProfile)
                                  ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            );
          },
        );
      }),
    );
  }
}

import 'dart:async';

import 'package:dekcare_frontend/components/chat/chatHeader.dart';
import 'package:dekcare_frontend/components/chat/messageBox.dart';
import 'package:dekcare_frontend/components/chat/messageBubble.dart';
import 'package:dekcare_frontend/components/constants.dart';
import 'package:dekcare_frontend/provider/chatProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndividualChatScreen extends StatefulWidget {
  final id, name, picture;
  IndividualChatScreen({this.id, this.name, this.picture});

  @override
  _IndividualChatScreenState createState() => _IndividualChatScreenState();
}

class _IndividualChatScreenState extends State<IndividualChatScreen> {
  void getChatContentList(id) async {
    try {
      await Provider.of<ChatProvider>(context, listen: false)
          .getListOfChatContent(id);
    } catch (err) {
      print(err);
    }
  }

  Widget renderScreenChanges(id) {
    getChatContentList(id);
    return Consumer<ChatProvider>(
      builder: (context, value, child) {
        final chatContent = value.chatContentList;
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: chatContent.length,
          itemBuilder: (context, index) {
            String processedDate() {
              var temp =
                  chatContent[index][0].datetime.substring(0, 10).split("-");
              return temp[2] + "/" + temp[1] + "/" + temp[0];
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(
                        processedDate(),
                        style: TextStyle(fontSize: 13, color: greySecondary),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: blackPrimaryFont.withAlpha(100),
                    ),
                    // style: BoxDecoration(),
                  ),
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: chatContent[index].length,
                    itemBuilder: (context, index2) {
                      return MessageBubble(
                        message: chatContent[index][index2].message,
                        isOwner: chatContent[index][index2].isFromYourself,
                        datetime: chatContent[index][index2].datetime,
                        profile: widget.picture,
                      );
                    }),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 10), (timer) {
      renderScreenChanges(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'supermarket'),
        home: Scaffold(
          backgroundColor: greySecondary,
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
            child: ChatHeader(
                name: widget.name,
                profile: widget.picture,
                contextFromPage: context),
            preferredSize: Size.fromHeight(height * 0.12),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 8,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      reverse: true,
                      child: Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: renderScreenChanges(widget.id)),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: MessageBox(
                          id: widget.id,
                          refresher: () {
                            renderScreenChanges(widget.id);
                          }),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

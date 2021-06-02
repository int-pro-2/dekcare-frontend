import 'package:dekcare_frontend/components/chat/chatHeader.dart';
import 'package:dekcare_frontend/components/chat/messageBox.dart';
import 'package:dekcare_frontend/components/chat/messageBubble.dart';
import 'package:dekcare_frontend/components/constants.dart';
import 'package:flutter/material.dart';

class IndividualChatScreen extends StatefulWidget {
  final id, name, picture;
  IndividualChatScreen({this.id, this.name, this.picture});

  @override
  _IndividualChatScreenState createState() => _IndividualChatScreenState();
}

class _IndividualChatScreenState extends State<IndividualChatScreen> {
  List<bool> mockChat = [
    true,
    false,
    true,
    false,
    true,
    true,
    false,
    false,
    false
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
          body: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: mockChat.length,
                          itemBuilder: (context, index) {
                            return MessageBubble(
                              isOwner: mockChat[index],
                              datetime: 'เมื่อวาน 22:08',
                            );
                          })),
                ),
                MessageBox()
              ],
            ),
          ),
        ));
  }
}

final String image =
    'https://scontent.fkdt2-1.fna.fbcdn.net/v/t1.6435-9/53458185_2150818338340159_4143062862610300928_n.jpg?_nc_cat=100&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=TZrNhZRqI6MAX9Nv44L&_nc_ht=scontent.fkdt2-1.fna&oh=9e7fd4dc6eeb448b34a3576abd63698c&oe=60D970C9';

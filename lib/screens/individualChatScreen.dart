import 'package:dekcare_frontend/components/chat/chatHeader.dart';
import 'package:flutter/material.dart';

class IndividualChatScreen extends StatefulWidget {
  final id;
  IndividualChatScreen({this.id});

  @override
  _IndividualChatScreenState createState() => _IndividualChatScreenState();
}

class _IndividualChatScreenState extends State<IndividualChatScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'supermarket'),
        home: Scaffold(
          appBar: PreferredSize(
            child: ChatHeader(
              name: 'นพ.วิรวรรธ ใจอารีย์',
              profile: image,
              contextFromPage: context,
            ),
            preferredSize: Size.fromHeight(height * 0.12),
          ),
        ));
  }
}

final String image =
    'https://scontent.fkdt2-1.fna.fbcdn.net/v/t1.6435-9/53458185_2150818338340159_4143062862610300928_n.jpg?_nc_cat=100&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=TZrNhZRqI6MAX9Nv44L&_nc_ht=scontent.fkdt2-1.fna&oh=9e7fd4dc6eeb448b34a3576abd63698c&oe=60D970C9';

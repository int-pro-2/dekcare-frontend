import 'package:dekcare_frontend/components/navBar/nav.dart';
import 'package:dekcare_frontend/Components/TopBar.dart';
import 'package:dekcare_frontend/Components/searchBar.dart';
import 'package:flutter/material.dart';
import 'package:dekcare_frontend/Components/constants.dart';

class ForumScreen extends StatefulWidget {
  @override
  _ForumState createState() => _ForumState();
}

class _ForumState extends State<ForumScreen> {
  @override
  Widget build(BuildContext context) {
    @override
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'supermarket'),
      home: Scaffold(
        backgroundColor: greySecondary,
        appBar: PreferredSize(
            child: TopBar(titleText: 'สนทนา', enableBackButton: false),
            preferredSize: Size.fromHeight(height * 0.075)),
        bottomNavigationBar: Nav(
          currentIndex: 2,
        ),
        body: Column(
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
                    onPressed: () {},
                    child: Icon(
                      Icons.add_comment,
                      color: yellowPrimary,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

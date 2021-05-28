import 'package:dekcare_frontend/components/navBar/nav.dart';

import 'package:flutter/material.dart';

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
    return Scaffold(
      bottomNavigationBar: Nav(
        currentIndex: 2,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Text('Forum')
        ],
      ),
    );
  }
}

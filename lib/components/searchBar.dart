import 'package:dekcare_frontend/Components/constants.dart';
import 'package:flutter/material.dart';

class searchBar extends StatefulWidget {
  final title, controller;

  searchBar({this.title, this.controller});

  @override
  _searchBarState createState() => _searchBarState();
}

class _searchBarState extends State<searchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            width: 325,
            height: 55,
            decoration: BoxDecoration(
              color: whitePrimary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: widget.controller,
              decoration: InputDecoration(
                  hintText: widget.title,
                  hintStyle: TextStyle(fontFamily: 'supermarket', fontSize: 18),
                  icon: Icon(
                    Icons.search,
                    color: Colors.black54,
                  ),
                  border: InputBorder.none),
            )));
  }
}

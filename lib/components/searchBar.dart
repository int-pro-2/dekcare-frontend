import 'package:dekcare_frontend/Components/constants.dart';
import 'package:flutter/material.dart';

class searchBar extends StatefulWidget {
  final String title;

  searchBar({required this.title});

  @override
  _searchBarState createState() => _searchBarState();
}

class _searchBarState extends State<searchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: const EdgeInsets.only(top: ),
        child: Container(
            width: MediaQuery.of(context).size.width * 0.90,
            height: MediaQuery.of(context).size.height * 0.06,
            child: TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: widget.title,
                contentPadding: EdgeInsets.all(8),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: whitePrimary),
                    borderRadius: BorderRadius.circular(5)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: whitePrimary),
                    borderRadius: BorderRadius.circular(5)),
                fillColor: whitePrimary,
                filled: true,
                prefixIcon: Icon(
                  Icons.search,
                  color: greyPrimary,
                ),
              ),
              style: TextStyle(fontSize: 14),
            )));
  }
}

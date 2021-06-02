import 'package:dekcare_frontend/components/constants.dart';
import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  final message;
  MessageBox({this.message});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Center(
        child: Container(
          width: width * 0.9,
          child: TextField(
            cursorColor: yellowPrimary,
            decoration: InputDecoration(
              fillColor: whitePrimary,
              hintText: "Type a message...",
              hintStyle: TextStyle(color: greyPrimary),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: greyPrimary, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              border: new OutlineInputBorder(
                borderSide: new BorderSide(color: greyPrimary, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              suffixIcon: Icon(
                Icons.send,
                color: yellowPrimary,
              ),
              filled: true,
            ),
          ),
        ),
      ),
    );
  }
}

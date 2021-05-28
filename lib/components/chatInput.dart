import 'package:dekcare_frontend/Components/constants.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatefulWidget {
  final title, controller;
  final double widthh;
  final double heightt;

  ChatInput(
      {this.title,
      this.controller,
      required this.widthh,
      required this.heightt});

  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
            padding: EdgeInsets.only(left: 15),
            width: widget.widthh,
            height: widget.heightt,
            decoration: BoxDecoration(
              color: greySecondary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: widget.controller,
              decoration: InputDecoration(
                  hintText: widget.title,
                  hintStyle: TextStyle(fontFamily: 'supermarket', fontSize: 18),
                  suffixIcon: ElevatedButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.send,
                        color: Colors.black54,
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(greySecondary),
                          shadowColor: MaterialStateProperty.all<Color>(
                            Colors.transparent,
                          ))),
                  border: InputBorder.none),
            )));
  }
}

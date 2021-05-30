import 'package:dekcare_frontend/components/constants.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatefulWidget {
  final title, controller, hasShadow, isCreate, onchange;
  final object;

  final Color color;
  final double widthh;
  final double heightt;

  ChatInput(
      {this.title,
      this.onchange,
      this.object,
      this.isCreate,
      this.hasShadow,
      required this.color,
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
                color: widget.color,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  widget.hasShadow
                      ? BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        )
                      : BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 0,
                          blurRadius: 0,
                          offset: Offset(0, 0),
                        )
                ]),
            child: TextField(
              keyboardType: TextInputType.text,
              onChanged: widget.onchange,
              controller: widget.controller,
              decoration: InputDecoration(
                  hintText: widget.title,
                  hintStyle: TextStyle(fontFamily: 'supermarket', fontSize: 18),
                  border: InputBorder.none),
            )));
  }
}

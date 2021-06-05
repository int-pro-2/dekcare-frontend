import 'package:dekcare_frontend/components/constants.dart';
import 'package:dekcare_frontend/provider/chatProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageBox extends StatefulWidget {
  Function refresher;
  double height = 20;

  final id;

  MessageBox({this.id, required this.refresher});

  @override
  _MessageBoxState createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  TextEditingController message = TextEditingController();
  Color enterColor = greyPrimary;

  void sendMessage(targetID, message, dateTime) async {
    try {
      await Provider.of<ChatProvider>(context, listen: false)
          .sendMessage(targetID, message, dateTime);
      widget.refresher();
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        height: 50,
        width: width * 0.95,
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(color: blackSecondaryFont, fontSize: 18),
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 4,
          cursorColor: yellowPrimary,
          controller: message,
          decoration: InputDecoration(
            fillColor: whitePrimary,
            hintText: "Type a message...",
            hintStyle: TextStyle(color: greyPrimary, fontSize: 18),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            suffixIcon: GestureDetector(
              child: Icon(
                Icons.send,
                color: enterColor,
              ),
              onTap: () {
                sendMessage(widget.id, message.text, DateTime.now().toString());
                message.text = '';
              },
            ),
            filled: true,
          ),
          onChanged: (value) {
            if (value.length > 0) {
              setState(() {
                enterColor = yellowPrimary;
              });
            } else {
              setState(() {
                enterColor = greyPrimary;
              });
            }
          },
        ),
      ),
    );
  }
}

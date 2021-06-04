import 'package:dekcare_frontend/components/constants.dart';
import 'package:flutter/material.dart';

class MessageBox extends StatefulWidget {
  TextEditingController message = TextEditingController();
  double height = 20;

  @override
  _MessageBoxState createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Center(
        child: Flexible(
          child: Container(
            width: width * 0.95,
            child: TextField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 4,
              cursorColor: yellowPrimary,
              controller: widget.message,
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
                suffixIcon: GestureDetector(
                  child: Icon(
                    Icons.send,
                    color: yellowPrimary,
                  ),
                  onTap: () {
                    print("Tapped!");
                  },
                ),
                filled: true,
              ),
              onChanged: (value) {
                // if (widget.message.length > 112) {}
                // print(value);
              },
            ),
          ),
        ),
      ),
    );
  }
}

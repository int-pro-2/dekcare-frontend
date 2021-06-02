import 'package:dekcare_frontend/components/constants.dart';
import 'package:flutter/material.dart';

class chatPreviewCard extends StatefulWidget {
  final name, profile, message, press;
  chatPreviewCard({this.name, this.profile, this.message, this.press});

  @override
  _chatPreviewCardState createState() => _chatPreviewCardState();
}

class _chatPreviewCardState extends State<chatPreviewCard> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
          height: 125,
          width: width * 0.95,
          child: MaterialButton(
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: whitePrimary,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x19000000),
                        blurRadius: 4,
                        offset: Offset(0, 4))
                  ]),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.profile),
                      // backgroundColor: greyPrimary,
                      radius: 45,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(children: [
                            Icon(
                              Icons.reply,
                              size: 18,
                            ),
                            Text(widget.message,
                                style: TextStyle(fontSize: 18)),
                          ]),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            onPressed: widget.press,
          )),
    );
  }
}

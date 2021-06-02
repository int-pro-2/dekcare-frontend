import 'package:dekcare_frontend/components/constants.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final message, datetime, profile;
  bool isOwner;
  MessageBubble(
      {required this.isOwner, this.message, this.datetime, this.profile});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return (isOwner
        ? /* 
          * ####################
          * ##  User message  ##
          * ####################
          */
        Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
                width: width * 0.9,
                height: 61,
                padding: EdgeInsets.only(right: 10),
                alignment: Alignment.centerRight,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.0),
                      child: Text("This is from me!",
                          style: TextStyle(fontSize: 18)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          color: whitePrimary),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10),
                      child: Text(
                        datetime,
                        style:
                            TextStyle(fontSize: 13, color: blackSecondaryFont),
                      ),
                    ),
                  ],
                )))
        : /* 
          * ######################
          * ##  Doctor message  ##
          * ######################
          */
        Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              width: width * 0.9,
              height: 80,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Container(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(image),
                        maxRadius: 25,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4,
                              color: blackSecondaryFont,
                              offset: Offset.fromDirection(1.5, 4))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 38,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                "This is from doctor!",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15)),
                              color: whitePrimary),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 10),
                          child: Text(
                            datetime,
                            style: TextStyle(
                                fontSize: 13, color: blackSecondaryFont),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
  }
}

var image = 'https://cdn.discordapp.com/emojis/844792977243373569.png?v=1';

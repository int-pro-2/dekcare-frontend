import 'package:dekcare_frontend/components/constants.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final message, datetime, profile;
  bool isOwner;
  MessageBubble(
      {required this.isOwner, this.message, this.datetime, this.profile});

  String formattedDateTime() {
    final processedTime = datetime.substring(11, 16);
    return processedTime;
  }

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
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Container(
                width: width * 0.9,
                padding: EdgeInsets.only(right: 10),
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 3, right: 10),
                        child: Text(
                          formattedDateTime(),
                          style: TextStyle(
                            fontSize: 13,
                            color: blackSecondaryFont,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 8,
                      child: Container(
                        padding: EdgeInsets.all(12.0),
                        child: SelectableText(
                          message,
                          style: TextStyle(
                              fontSize: 18,
                              color: blackSecondaryFont,
                              height: 1.1),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                            color: whitePrimary),
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
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Container(
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              width: width * 0.9,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Container(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(profile),
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
                  ),
                  Flexible(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            flex: 4,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SelectableText(
                                  message,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: blackSecondaryFont,
                                    height: 1.1,
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
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 3, left: 10, right: 10),
                            child: Text(
                              formattedDateTime(),
                              style: TextStyle(
                                  fontSize: 13, color: blackSecondaryFont),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ));
  }
}

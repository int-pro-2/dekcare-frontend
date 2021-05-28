import 'package:dekcare_frontend/components/button.dart';
import 'package:flutter/material.dart';
import 'package:dekcare_frontend/components/constants.dart';

class CardForum extends StatelessWidget {
  final press, text, title, userName, comment;

  const CardForum(
      {this.press, this.text, this.title, this.userName, this.comment});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return TextButton(
      onPressed: () {},
      child: Container(
        child: SizedBox(
          width: width * 0.95,
          // height: height * (25 / 100),
          child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(23),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ]),
              child: Column(
                children: [
                  SizedBox(height: height * 0.02),
                  Container(
                    padding: EdgeInsets.only(left: 20, top: 10),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 23,
                          fontFamily: 'supermarket',
                          color: blackPrimaryFont,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      text,
                      style: TextStyle(
                          height: 1.3,
                          fontSize: 20,
                          fontFamily: 'supermarket',
                          color: blackSecondaryFont,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                  Container(
                    width: width * 0.9,
                    child: Divider(
                      height: 5,
                      thickness: 2,
                      indent: 10,
                      endIndent: 10,
                    ),
                  ),
                  Container(
                      height: height * 0.07,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: CircleAvatar(
                              backgroundColor: greyPrimary,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            userName,
                            style: TextStyle(
                                height: 1.3,
                                fontSize: 20,
                                fontFamily: 'supermarket',
                                color: blackPrimaryFont,
                                fontStyle: FontStyle.normal),
                          ),
                          Container(
                            width: width * 0.52,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.mode_comment_outlined,
                                    color: yellowPrimary,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    comment + " comments",
                                    style: TextStyle(
                                        height: 1.3,
                                        fontSize: 20,
                                        fontFamily: 'supermarket',
                                        color: yellowPrimary,
                                        fontStyle: FontStyle.normal),
                                  ),
                                ]),
                          )
                        ],
                      ))
                ],
              )),
        ),
      ),
    );
  }
}

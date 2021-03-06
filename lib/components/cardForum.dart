
import 'package:flutter/material.dart';
import 'package:dekcare_frontend/components/constants.dart';

class CardForum extends StatelessWidget {
  final press,
      commentorReply,
      isReply,
      color,
      myFocusNode,
      replypress,
      text,
      controller,
      title,
      userName,
      comment,
      isInside,
      date,
      commentID,
      isComment,
      url,
      hello;
  final Function pressComment;
  const CardForum(
      {this.press,
      this.commentorReply,
      this.color,
      this.isReply,
      this.myFocusNode,
      this.replypress,
      this.controller,
      this.isComment,
      this.commentID,
      this.text,
      this.title,
      this.userName,
      this.comment,
      this.isInside,
      this.date,
      this.url,
      this.hello,
      required this.pressComment});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return TextButton(
      onPressed: press,
      child: Container(
        child: SizedBox(
          width: width * 0.95,
          // height: height * (25 / 100),
          child: DecoratedBox(
              decoration: BoxDecoration(
                  color: color,
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
                  isComment
                      ? Container(
                          padding: EdgeInsets.only(left: 20, top: 10),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            (commentorReply + (commentID).toString()),
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'supermarket',
                                color: blackPrimaryFont,
                                fontStyle: FontStyle.normal),
                          ))
                      : Container(
                          padding: EdgeInsets.only(left: 20, top: 10),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            title,
                            style: TextStyle(
                                fontSize: 23,
                                fontFamily: 'supermarket',
                                color: blackPrimaryFont,
                                fontStyle: FontStyle.normal),
                          )),
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
                              // backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(url),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: width * 0.28,
                            child: Text(
                              userName,
                              style: TextStyle(
                                  height: 1.3,
                                  fontSize: 18,
                                  fontFamily: 'supermarket',
                                  color: blackPrimaryFont,
                                  fontStyle: FontStyle.normal),
                            ),
                          ),
                          isInside
                              ? isComment
                                  ? isReply
                                      ? Container(
                                          width: width * 0.45,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                    onPressed: replypress,
                                                    focusNode: myFocusNode,
                                                    child:
                                                        Text('?????????????????????????????????????????????'))
                                              ]),
                                        )
                                      : Container()
                                  : Container(
                                      width: width * 0.45,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              date,
                                              style: TextStyle(
                                                  height: 1.3,
                                                  fontSize: 20,
                                                  fontFamily: 'supermarket',
                                                  color: blackPrimaryFont,
                                                  fontStyle: FontStyle.normal),
                                            ),
                                          ]),
                                    )
                              : Container(
                                  width: width * 0.45,
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
                                          comment.toString() + " comments",
                                          style: TextStyle(
                                              height: 1.3,
                                              fontSize: 20,
                                              fontFamily: 'supermarket',
                                              color: yellowPrimary,
                                              fontStyle: FontStyle.normal),
                                        ),
                                      ]),
                                ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      )),
                  SizedBox(
                    width: 10,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

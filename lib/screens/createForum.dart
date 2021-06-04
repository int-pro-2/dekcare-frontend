import 'package:dekcare_frontend/components/button.dart';
import 'package:dekcare_frontend/components/cardForum.dart';
import 'package:dekcare_frontend/components/chatInput.dart';
import 'package:dekcare_frontend/components/constants.dart';
import 'package:dekcare_frontend/components/navBar/nav.dart';
import 'package:dekcare_frontend/screens/forumScreen.dart';
import 'package:dekcare_frontend/screens/loginScreen.dart';
import 'package:dekcare_frontend/provider/forumProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class CreaetForumScreen extends StatefulWidget {
  @override
  _CreaetForumScreenState createState() => _CreaetForumScreenState();
}

class _CreaetForumScreenState extends State<CreaetForumScreen> {
  @override
  var topicCheck = '';
  var bodyCheck = '';

  var topicCheckError = '';
  var bodyCheckError = '';

  void createForum() async {
    print('create Forum');
    try {
      await Provider.of<ForumProvider>(context, listen: false).createForum(
          topicController.text, bodyController.text, DateTime.now().toString());
      Navigator.pop(context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ForumScreen();
          },
        ),
      );
    } catch (error) {
      print(error);
    }
    print('done create forumm');
  }

  final TextEditingController topicController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  Widget build(BuildContext context) {
    @override
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: greySecondary,
      bottomNavigationBar: Container(
        height: height * 0.09,
        color: whitePrimary,
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Button(
            title: 'ยืนยัน',
            color: (topicCheck != '' && bodyCheck != '')
                ? yellowPrimary
                : greyPrimary,
            onPress: () {
              if (topicCheck == '') {
                setState(() {
                  topicCheckError = 'error';
                });
              }
              if (bodyCheck == '') {
                setState(() {
                  bodyCheckError = 'error';
                });
              }
              if (topicCheck != '' && bodyCheck != '') {
                createForum();
              }
              if (topicCheck == '' && bodyCheck == '') {
                print('topic and body are not complete');
              }
            },
          ),
        ),
      ),
      appBar: AppBar(
          title: Text(
            'สร้างกระทู้',
            style: TextStyle(fontSize: 23),
          ),
          centerTitle: true,
          backgroundColor: yellowPrimary,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(30)))),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: width,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 15),
                  child: ChatInput(
                    onchange: (text) {
                      setState(() {
                        topicCheck = text;
                      });
                      setState(() {
                        topicCheckError = '';
                      });
                    },
                    controller: topicController,
                    isCreate: true,
                    title: 'ตั้งหัวข้อคำถามตรงนี้...',
                    color: whitePrimary,
                    widthh: width * 0.9,
                    heightt: height * 0.06,
                    hasShadow: false,
                  ),
                ),
                topicCheckError == 'error'
                    ? Container(
                        width: width,
                        padding: EdgeInsets.only(top: 20, left: 25),
                        child: Text(
                          'โปรดกรอกหัวข้อก่อนยืนยัน',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      )
                    : Container(),
                Container(
                  padding: EdgeInsets.all(15),
                  child: ChatInput(
                    controller: bodyController,
                    isCreate: true,
                    onchange: (text) {
                      setState(() {
                        bodyCheck = text;
                      });
                      setState(() {
                        bodyCheckError = '';
                      });
                    },
                    title: 'เนื้อหากระทู้...',
                    color: whitePrimary,
                    widthh: width * 0.9,
                    heightt: height * 0.3,
                    hasShadow: false,
                  ),
                ),
                bodyCheckError == 'error'
                    ? Container(
                        width: width,
                        padding: EdgeInsets.only(top: 20, left: 25),
                        child: Text(
                          'โปรดกรอกเนื้อหากระทู้ก่อนยืนยัน',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      )
                    : Container(),
                Container(
                  padding: EdgeInsets.only(left: 25, top: 25),
                  width: width,
                  child: Text(
                    '*ร่วมพูดคุยแลกเปลี่ยนความคิดเห็นในทุกประเด็น ',
                    style: TextStyle(fontSize: 18, color: blackSecondaryFont),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 25, top: 10),
                  width: width,
                  child: Text(
                    '*โปรดใช้คำพูดที่สุภาพ เพื่อสังคมที่ดีของ DekCare',
                    style: TextStyle(fontSize: 18, color: blackSecondaryFont),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

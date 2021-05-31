import 'package:dekcare_frontend/components/CalendarPicker.dart';
import 'package:dekcare_frontend/components/button.dart';
import 'package:dekcare_frontend/components/chatInput.dart';
import 'package:flutter/cupertino.dart';
import 'package:dekcare_frontend/components/constants.dart';

import 'package:dekcare_frontend/screens/forumScreen.dart';

import 'package:dekcare_frontend/provider/authenticateProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

bool _passwordVisible = false;
bool _confirmPasswordVisible = false;

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  var emailCheck = '';
  var passwordCheck = '';
  var confirmPasswordCheck = '';

  var emailCheckError = '';
  var passwordCheckError = '';
  var confirmPasswordCheckError = '';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // void register() async {
  //   try {
  //     await Provider.of<AuthenticateProvider>(context, listen: false)
  //         .register(emailController.text, passwordController.text);
  //   } catch (error) {
  //     print(error);
  //   }
  // }
  DateTime selectedDate = DateTime.now();

  String changeDate(date) {
    setState(() {
      selectedDate = date;
    });
    return selectedDate.toString().split(" ")[0];
  }

  Widget build(BuildContext context) {
    bool isChecked = false;
    @override
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(passwordCheckError);
    bool valuefirst = false;
    Color hexToColor(int rgb) => new Color(0xFF000000 + rgb);
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: hexToColor(0x335C81),
        accentColor: hexToColor(0xFCA311),
        splashColor: hexToColor(0x3BB273),
      ),
      home: Scaffold(
        backgroundColor: whitePrimary,
        bottomNavigationBar: Container(
          height: height * 0.09,
          color: whitePrimary,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Button(
              title: 'ยืนยัน',
              color: (emailCheck != '' &&
                      passwordCheck != '' &&
                      confirmPasswordCheck != '')
                  ? yellowPrimary
                  : greyPrimary,
              onPress: () {
                emailCheck = emailController.text;
                passwordCheck = passwordController.text;
                confirmPasswordCheck = confirmPasswordController.text;
                if (emailCheck == '') {
                  setState(() {
                    emailCheck = 'error';
                  });
                }
                if (passwordCheck == '') {
                  setState(() {
                    passwordCheck = 'error';
                  });
                }
                if (confirmPasswordCheck == '') {
                  setState(() {
                    confirmPasswordCheck = 'error';
                  });
                }
                if (emailCheck != '' && passwordCheck != '') {
                  // createForum();
                }
                if (emailCheck == '' && passwordCheck == '') {
                  print('topic and body are not complete');
                }
              },
            ),
          ),
        ),
        appBar: AppBar(
            title: Text(
              'สมัครสมาชิก',
              style: TextStyle(fontSize: 23),
            ),
            centerTitle: true,
            backgroundColor: yellowPrimary,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)))),
        body: SingleChildScrollView(
          child: Container(
            width: width,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                    padding: EdgeInsets.only(left: 25, top: 15, bottom: 15),
                    width: width,
                    child: Text(
                      'บัญชีผู้ใช้',
                      style: TextStyle(
                          fontFamily: 'supermarket',
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    )),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                    width: 350,
                    height: 55,
                    decoration: BoxDecoration(
                      color: greySecondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      onChanged: (text) {
                        setState(() {
                          print(text);
                          emailCheck = text;
                        });
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: 'บัญชีผู้ใช้',
                          hintStyle: TextStyle(
                              fontFamily: 'supermarket', fontSize: 18),
                          icon: Icon(
                            Icons.person_rounded,
                            color: Colors.black54,
                          ),
                          border: InputBorder.none),
                    )),
                emailCheck == 'error'
                    ? Container(
                        width: width,
                        padding: EdgeInsets.only(top: 20, left: 25),
                        child: Text(
                          'โปรดใส่อีเมลบัญชีผู้ใช้',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      )
                    : Container(),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                    width: 350,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      onChanged: (text) {
                        passwordCheck = text;
                        print(passwordCheck);
                      },
                      controller: passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                          hintText: 'รหัสผ่าน',
                          hintStyle: TextStyle(
                              fontFamily: 'supermarket', fontSize: 18),
                          icon: Icon(
                            Icons.lock,
                            color: Colors.black54,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black54,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          border: InputBorder.none),
                    )),
                passwordCheck == 'error'
                    ? Container(
                        width: width,
                        padding: EdgeInsets.only(top: 20, left: 25),
                        child: Text(
                          'โปรดกรอกรหัสผ่าน',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      )
                    : Container(),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                    width: 350,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      onChanged: (text) {
                        confirmPasswordCheck = text;
                      },
                      controller: confirmPasswordController,
                      obscureText: !_confirmPasswordVisible,
                      decoration: InputDecoration(
                          hintText: 'ยืนยันรหัสผ่าน',
                          hintStyle: TextStyle(
                              fontFamily: 'supermarket', fontSize: 18),
                          icon: Icon(
                            Icons.lock,
                            color: Colors.black54,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _confirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black54,
                            ),
                            onPressed: () {
                              setState(() {
                                _confirmPasswordVisible =
                                    !_confirmPasswordVisible;
                              });
                            },
                          ),
                          border: InputBorder.none),
                    )),
                confirmPasswordCheck == 'error'
                    ? Container(
                        width: width,
                        padding: EdgeInsets.only(top: 20, left: 25),
                        child: Text(
                          'โปรดกรอกรหัสผ่านอีกครั้งเพื่อยืนยัน',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      )
                    : Container(),
                Container(
                    padding: EdgeInsets.only(left: 25, top: 15, bottom: 15),
                    width: width,
                    child: Text(
                      'ข้อมูลพื้นฐาน',
                      style: TextStyle(
                          fontFamily: 'supermarket',
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    )),
                Container(
                  padding: EdgeInsets.only(top: 15),
                  child: ChatInput(
                    onchange: (text) {
                      // setState(() {
                      //   topicCheck = text;
                      // });
                      // setState(() {
                      //   topicCheckError = '';
                      // });
                    },
                    // controller: topicController,
                    isCreate: true,
                    title: 'ชื่อจริง..',
                    color: greySecondary,
                    widthh: width * 0.9,
                    heightt: height * 0.06,
                    hasShadow: false,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 15),
                  child: ChatInput(
                    onchange: (text) {
                      // setState(() {
                      //   topicCheck = text;
                      // });
                      // setState(() {
                      //   topicCheckError = '';
                      // });
                    },
                    // controller: topicController,
                    isCreate: true,
                    title: 'นามสกุล..',
                    color: greySecondary,
                    widthh: width * 0.9,
                    heightt: height * 0.06,
                    hasShadow: false,
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(left: 25, top: 15, bottom: 15),
                    width: width,
                    child: Text(
                      'วันเกิดของลูก',
                      style: TextStyle(
                          fontFamily: 'supermarket',
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    )),
                Container(
                    width: width * 0.6,
                    height: height * 0.1,
                    // padding: EdgeInsets.all(20),
                    child: buildDatePicker()),
                // Container(
                //   padding: EdgeInsets.only(top: 15),
                //   width: width * 0.9,
                //   child: CalendarPicker(
                //     title: selectedDate.toString().split(" ")[0] ==
                //             DateTime.now().toString().split(" ")[0]
                //         ? "วันเกิดของลูก"
                //         : selectedDate.toString().split(" ")[0]
                //     // changeDate(selectedDate)
                //     ,
                //     color: greySecondary,
                //     fontColor: greyPrimary,
                //     onPickDate: changeDate,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DateTime dateTime = DateTime.now();
  Widget buildDatePicker() => SizedBox(
        height: 180,
        child: CupertinoDatePicker(
          minimumYear: 1998,
          maximumYear: DateTime.now().year,
          initialDateTime: dateTime,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) =>
              setState(() => this.dateTime = dateTime),
        ),
      );
}

import 'package:dekcare_frontend/components/button.dart';
import 'package:dekcare_frontend/components/chatInput.dart';
import 'package:dekcare_frontend/model/httpException.dart';
import 'package:dekcare_frontend/provider/forumProvider.dart';
import 'package:dekcare_frontend/screens/loginScreen.dart';
import 'package:dekcare_frontend/screens/settingScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:dekcare_frontend/components/constants.dart';

import 'package:dekcare_frontend/screens/forumScreen.dart';

import 'package:dekcare_frontend/provider/authenticateProvider.dart';
import 'package:dekcare_frontend/components/topBar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

bool _oldPasswordVisible = false;

bool _passwordVisible = false;
bool _confirmPasswordVisible = false;

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  var oldPasswordCheck = '';
  var passwordCheck = '';
  var confirmPasswordCheck = '';

  var emailCheckUsed = '';

  bool passwordEqual = true;

  var oldPasswordCheckError = '';
  var passwordCheckError = '';
  var confirmPasswordCheckError = '';

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  DateTime selectedDate = DateTime.now();

  String changeDate(date) {
    setState(() {
      selectedDate = date;
    });
    return selectedDate.toString().split(" ")[0];
  }

  void changePassword() async {
    try {
      await Provider.of<AuthenticateProvider>(context, listen: false)
          .changePassword(oldPasswordController.text, passwordController.text);
      Navigator.pop(context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return SettingScreen();
          },
        ),
      );
    } catch (error) {
      setState(() {
        emailCheckUsed = error.toString();
      });
      print(error);
    }
  }

  Widget build(BuildContext context) {
    @override
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'supermarket'),
      home: Scaffold(
        backgroundColor: whitePrimary,
        bottomNavigationBar: Container(
          height: height * 0.09,
          color: whitePrimary,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Button(
              title: 'ยืนยัน',
              color: (oldPasswordCheck != '' &&
                      passwordCheck != '' &&
                      confirmPasswordCheck != '')
                  ? yellowPrimary
                  : greyPrimary,
              onPress: () {
                oldPasswordCheck = oldPasswordController.text;
                passwordCheck = passwordController.text;
                confirmPasswordCheck = confirmPasswordController.text;

                if (confirmPasswordController.text != passwordController.text) {
                  setState(() {
                    passwordEqual = false;
                  });
                }
                if (oldPasswordCheck == '') {
                  setState(() {
                    oldPasswordCheckError = 'error';
                  });
                }
                if (passwordCheck == '') {
                  setState(() {
                    passwordCheckError = 'error';
                  });
                }
                if (confirmPasswordCheck == '') {
                  setState(() {
                    confirmPasswordCheckError = 'error';
                  });
                }

                if (oldPasswordCheck != '' &&
                    passwordCheck != '' &&
                    confirmPasswordCheck != '') {
                  changePassword();
                  print('changePassword');
                }
              },
            ),
          ),
        ),
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text(
              'เปลี่ยนรหัสผ่าน',
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
                        oldPasswordCheck = text;

                        setState(() {
                          oldPasswordCheckError = '';
                          passwordEqual = true;
                        });
                      },
                      controller: oldPasswordController,
                      obscureText: !_oldPasswordVisible,
                      decoration: InputDecoration(
                          hintText: 'รหัสผ่านเดิม',
                          hintStyle: TextStyle(
                              fontFamily: 'supermarket', fontSize: 18),
                          icon: Icon(
                            Icons.lock,
                            color: Colors.black54,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _oldPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black54,
                            ),
                            onPressed: () {
                              setState(() {
                                _oldPasswordVisible = !_oldPasswordVisible;
                              });
                            },
                          ),
                          border: InputBorder.none),
                    )),
                oldPasswordCheckError == 'error'
                    ? Container(
                        width: width,
                        padding: EdgeInsets.only(top: 20, left: 25),
                        child: Text(
                          'โปรดกรอกรหัสผ่านเดิม',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      )
                    : Container(),
                emailCheckUsed != ''
                    ? Container(
                        width: width,
                        padding: EdgeInsets.only(top: 20, left: 25),
                        child: Text(
                          'รหัสผ่านผิด',
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

                        setState(() {
                          passwordCheckError = '';
                          passwordEqual = true;
                        });
                      },
                      controller: passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                          hintText: 'รหัสผ่านใหม่',
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
                passwordCheckError == 'error'
                    ? Container(
                        width: width,
                        padding: EdgeInsets.only(top: 20, left: 25),
                        child: Text(
                          'โปรดกรอกรหัสผ่านใหม่',
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
                        setState(() {
                          confirmPasswordCheckError = '';
                          passwordEqual = true;
                        });
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
                confirmPasswordCheckError == 'error'
                    ? Container(
                        width: width,
                        padding: EdgeInsets.only(top: 20, left: 25),
                        child: Text(
                          'โปรดกรอกรหัสผ่านใหม่อีกครั้งเพื่อยืนยัน',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      )
                    : Container(),
                passwordEqual == false
                    ? Container(
                        width: width,
                        padding: EdgeInsets.only(top: 20, left: 25),
                        child: Text(
                          'รหัสผ่านใหม่ไม่ตรงกัน',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

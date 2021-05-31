import 'package:dekcare_frontend/components/button.dart';

import 'package:dekcare_frontend/components/constants.dart';

import 'package:dekcare_frontend/screens/forumScreen.dart';

import 'package:dekcare_frontend/provider/forumProvider.dart';
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

  Widget build(BuildContext context) {
    @override
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(passwordCheckError);

    return Scaffold(
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
                        hintStyle:
                            TextStyle(fontFamily: 'supermarket', fontSize: 18),
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
                        hintStyle:
                            TextStyle(fontFamily: 'supermarket', fontSize: 18),
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
                        hintStyle:
                            TextStyle(fontFamily: 'supermarket', fontSize: 18),
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
            ],
          ),
        ),
      ),
    );
  }
}

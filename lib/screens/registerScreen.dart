import 'package:dekcare_frontend/components/button.dart';
import 'package:dekcare_frontend/components/chatInput.dart';
import 'package:dekcare_frontend/model/httpException.dart';
import 'package:dekcare_frontend/screens/loginScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:dekcare_frontend/components/constants.dart';

import 'package:dekcare_frontend/screens/forumScreen.dart';

import 'package:dekcare_frontend/provider/authenticateProvider.dart';
import 'package:dekcare_frontend/components/topBar.dart';
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
  var firstnameCheck = '';
  var lastnameCheck = '';
  var emailCheckUsed = '';

  bool passwordEqual = true;

  var emailCheckError = '';
  var passwordCheckError = '';
  var confirmPasswordCheckError = '';
  var firstnameCheckError = '';
  var lastnameCheckError = '';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController firstnameController = TextEditingController();

  final TextEditingController lastnameController = TextEditingController();

  void register() async {
    try {
      await Provider.of<AuthenticateProvider>(context, listen: false).register(
          emailController.text,
          passwordController.text,
          firstnameController.text,
          lastnameController.text,
          // '2021-05-31'
          dateTime.toString().substring(0, 10));
      Navigator.pop(context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        ),
      );
    } on HttpException catch (error) {
      setState(() {
        emailCheckUsed = error.toString();
      });

      print(emailCheckUsed + '?????????????????????');
      print(error);
    }
  }

  DateTime selectedDate = DateTime.now();

  String changeDate(date) {
    setState(() {
      selectedDate = date;
    });
    return selectedDate.toString().split(" ")[0];
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
              title: '??????????????????',
              color: (emailCheck != '' &&
                      passwordCheck != '' &&
                      confirmPasswordCheck != '' &&
                      firstnameCheck != '' &&
                      lastnameCheck != '')
                  ? yellowPrimary
                  : greyPrimary,
              onPress: () {
                emailCheck = emailController.text;
                passwordCheck = passwordController.text;
                confirmPasswordCheck = confirmPasswordController.text;
                firstnameCheck = firstnameController.text;
                lastnameCheck = lastnameController.text;

                if (confirmPasswordController.text != passwordController.text) {
                  setState(() {
                    passwordEqual = false;
                  });
                }
                if (emailCheck == '') {
                  setState(() {
                    emailCheckError = 'error';
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
                if (firstnameCheck == '') {
                  setState(() {
                    firstnameCheckError = 'error';
                  });
                }
                if (lastnameCheck == '') {
                  setState(() {
                    lastnameCheckError = 'error';
                  });
                }
                if (confirmPasswordCheckError == '') {
                  setState(() {
                    confirmPasswordCheck = 'error';
                  });
                }
                if (emailCheck != '' && passwordCheck != '') {
                  // createForum();
                }
                if (emailCheck != '' &&
                    passwordCheck != '' &&
                    confirmPasswordCheck != '' &&
                    firstnameCheck != '' &&
                    lastnameCheck != '') {
                  // register();
                  // print("email " + emailController.text);
                  // print("password " + passwordController.text);

                  // print("firstname " + firstnameController.text);

                  // print("lastname " + lastnameController.text);

                  // print("date " + dateTime.toString().substring(0, 10));
                  register();
                  print('registered');
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
              '?????????????????????????????????',
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
                      '????????????????????????????????????',
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
                          setState(() {
                            emailCheckError = '';
                          });
                        });
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: '???????????????',
                          hintStyle: TextStyle(
                              fontFamily: 'supermarket', fontSize: 18),
                          icon: Icon(
                            Icons.person_rounded,
                            color: Colors.black54,
                          ),
                          border: InputBorder.none),
                    )),
                emailCheckError == 'error'
                    ? Container(
                        width: width,
                        padding: EdgeInsets.only(top: 20, left: 25),
                        child: Text(
                          '?????????????????????????????????????????????????????????????????????',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      )
                    : Container(),
                emailCheckUsed != ''
                    ? Container(
                        width: width,
                        padding: EdgeInsets.only(top: 20, left: 25),
                        child: Text(
                          '????????????????????????????????????????????????????????????',
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
                        setState(() {
                          passwordCheckError = '';
                          passwordEqual = true;
                        });
                      },
                      controller: passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                          hintText: '????????????????????????',
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
                          '????????????????????????????????????????????????',
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
                          hintText: '??????????????????????????????????????????',
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
                          '?????????????????????????????????????????????????????????????????????????????????????????????????????????',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      )
                    : Container(),
                passwordEqual == false
                    ? Container(
                        width: width,
                        padding: EdgeInsets.only(top: 20, left: 25),
                        child: Text(
                          '???????????????????????????????????????????????????',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      )
                    : Container(),
                Container(
                    padding: EdgeInsets.only(left: 25, top: 15, bottom: 15),
                    width: width,
                    child: Text(
                      '???????????????????????????????????????',
                      style: TextStyle(
                          fontFamily: 'supermarket',
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    )),
                Container(
                  padding: EdgeInsets.only(top: 15),
                  child: ChatInput(
                    onchange: (text) {
                      setState(() {
                        firstnameCheck = text;
                      });
                      setState(() {
                        firstnameCheckError = '';
                      });
                    },
                    controller: firstnameController,
                    isCreate: true,
                    title: '????????????????????????',
                    color: greySecondary,
                    widthh: width * 0.9,
                    heightt: height * 0.06,
                    hasShadow: false,
                  ),
                ),
                firstnameCheckError == 'error'
                    ? Container(
                        width: width,
                        padding: EdgeInsets.only(top: 20, left: 25),
                        child: Text(
                          '????????????????????????????????????????????????',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      )
                    : Container(),
                Container(
                  padding: EdgeInsets.only(top: 15),
                  child: ChatInput(
                    onchange: (text) {
                      setState(() {
                        lastnameCheck = text;
                      });
                      setState(() {
                        lastnameCheckError = '';
                      });
                    },
                    controller: lastnameController,
                    isCreate: true,
                    title: '?????????????????????..',
                    color: greySecondary,
                    widthh: width * 0.9,
                    heightt: height * 0.06,
                    hasShadow: false,
                  ),
                ),
                lastnameCheckError == 'error'
                    ? Container(
                        width: width,
                        padding: EdgeInsets.only(top: 20, left: 25),
                        child: Text(
                          '?????????????????????????????????????????????',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      )
                    : Container(),
                Container(
                    padding: EdgeInsets.only(left: 25, top: 15, bottom: 15),
                    width: width,
                    child: Text(
                      '???????????????????????????????????????',
                      style: TextStyle(
                          fontFamily: 'supermarket',
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    )),
                Container(
                    width: width * 0.6,
                    height: height * 0.2,
                    child: buildDatePicker()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DateTime dateTime = DateTime.now();
  Widget buildDatePicker() => SizedBox(
        height: 240,
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

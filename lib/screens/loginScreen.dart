import 'package:dekcare_frontend/components/button.dart';
import 'package:dekcare_frontend/components/constants.dart';
import 'package:dekcare_frontend/provider/authenticateProvider.dart';
import 'package:dekcare_frontend/screens/registerScreen.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  void login() async {
    try {
      await Provider.of<AuthenticateProvider>(context, listen: false)
          .login(emailController.text, passwordController.text);
    } catch (error) {
      print(error);
    }
  }

  bool _passwordVisible = false;

  ScrollController _scrollController = ScrollController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      _passwordVisible = false;
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
          child: Scaffold(
        // backgroundColor: kPrimaryColor,
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 80,
              ),
              Text(
                'Welcome to DekCare',
                style: TextStyle(
                    // color: kPrimaryFont,
                    fontSize: 30,
                    fontFamily: 'supermarket'),
              ),
              Container(
                  padding: EdgeInsets.all(20),
                  height: 240,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('assets/images/Doctor.png'),
                        )),
                      )),
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  width: 325,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
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
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  width: 325,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
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
              SizedBox(
                height: 30,
              ),
              Button(
                  color: yellowPrimary,
                  onPress: () {
                    login();
                  },
                  title: 'Login'),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return RegisterScreen();
                          },
                        ),
                      );
                    });
                  },
                  child: Text(
                    'สมัครบัญชีผู้ใช้',
                    style: TextStyle(
                        color: blackPrimaryFont,
                        fontFamily: 'supermarket',
                        fontSize: 18),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

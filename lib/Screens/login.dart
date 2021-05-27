import 'package:dekcare_frontend/Components/button.dart';
import 'package:dekcare_frontend/Components/constants.dart';
import 'package:dekcare_frontend/Screens/landing.dart';

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
    return Scaffold(
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
            Container(
              width: width * 0.8,
              alignment: Alignment.bottomRight,
              child: TextButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text(
                    'ลืมรหัสผ่าน?',
                    style: TextStyle(
                        color: blackPrimaryFont,
                        fontFamily: 'supermarket',
                        fontSize: 18),
                  )),
            ),
            Button(
                color: yelloPrimary,
                onPress: () {
                  setState(() {});
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Landing();
                      },
                    ),
                  );
                },
                title: 'Login'),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  setState(() {});
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
    );
  }
}

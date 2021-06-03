import 'package:dekcare_frontend/components/button.dart';
import 'package:dekcare_frontend/components/buttonSetting.dart';
import 'package:dekcare_frontend/components/constants.dart';
import 'package:dekcare_frontend/components/text.dart';
import 'package:dekcare_frontend/components/textBoxSetting.dart';
import 'package:dekcare_frontend/provider/authenticateProvider.dart';
import 'package:dekcare_frontend/screens/changePassword.dart';
import 'package:dekcare_frontend/screens/loginScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<SettingScreen> {
  @override
  void logout() async {
    try {
      await Provider.of<AuthenticateProvider>(context, listen: false).logout();
    } catch (error) {
      print(error);
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LoginScreen();
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    @override
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'supermarket'),
      home: Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text(
              'ตั้งค่า',
              style: TextStyle(fontSize: 23),
            ),
            centerTitle: true,
            backgroundColor: yellowPrimary,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)))),
        body: SafeArea(
          child: Container(
            color: greySecondary,
            width: width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: TextButton(
                      onPressed: () {},
                      child: Stack(
                        children: [
                          Positioned(
                              child: Container(
                                  width: width * 0.2,
                                  height: height * 0.2,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://scontent.fkdt2-1.fna.fbcdn.net/v/t1.6435-9/84643335_3603241603051806_8217618763466407936_n.jpg?_nc_cat=107&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=RmEYSc-U9uUAX-BMXey&_nc_ht=scontent.fkdt2-1.fna&oh=d752ff94b05a97243b0443f45fdb908a&oe=60DDA4AE'),
                                  ))),
                          Positioned(
                              top: 80,
                              left: 50,
                              child: Container(
                                  width: width * 0.07,
                                  height: height * 0.07,
                                  child: CircleAvatar(
                                      backgroundColor: yellowPrimary,
                                      child: Icon(
                                        Icons.add,
                                        color: whitePrimary,
                                      ))))
                        ],
                      ),
                    ),
                  ),
                  TextKT(text: 'บัญชี'),
                  TextBoxSetting(
                    title: 'บัญชี',
                    info: 'Wirawat09@gmail.com',
                  ),
                  TextBoxSetting(
                    title: 'ชื่อ',
                    info: 'Wirawat Jaiarree',
                  ),
                  TextKT(text: 'อื่นๆ'),
                  ButtonSetting(
                    icon: Icons.lock,
                    text: 'เปลี่ยนรหัสผ่าน',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ChangePasswordScreen();
                          },
                        ),
                      );
                    },
                  ),
                  ButtonSetting(
                    icon: Icons.headset_mic,
                    text: 'ติดต่อเจ้าหน้าที่',
                    onPressed: () {
                      launch("tel://21213123123");
                    },
                  ),
                  ButtonSetting(
                    icon: Icons.exit_to_app,
                    text: 'ออกจากระบบ',
                    onPressed: () {
                      logout();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

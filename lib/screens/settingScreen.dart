import 'package:dekcare_frontend/components/button.dart';
import 'package:dekcare_frontend/components/buttonSetting.dart';
import 'package:dekcare_frontend/components/chatInput.dart';
import 'package:dekcare_frontend/components/constants.dart';
import 'package:dekcare_frontend/components/text.dart';
import 'package:dekcare_frontend/components/textBoxSetting.dart';
import 'package:dekcare_frontend/provider/authenticateProvider.dart';
import 'package:dekcare_frontend/provider/forumProvider.dart';
import 'package:dekcare_frontend/screens/changePassword.dart';
import 'package:dekcare_frontend/screens/loginScreen.dart';
import 'package:dekcare_frontend/screens/splashScreen.dart';
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LoginScreen();
        },
      ),
    );
  }

  Future<void> fetchUserProfile() async {
    try {
      await Provider.of<AuthenticateProvider>(context, listen: false)
          .fetchProfile();
    } catch (error) {}
  }

  void updatePic() async {
    try {
      await Provider.of<AuthenticateProvider>(context, listen: false)
          .updateProfilePicture(updatePictureController.text);
      await fetchUserProfile();
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final TextEditingController updatePictureController = TextEditingController();

  var isUpdatePicture = false;

  Widget build(BuildContext context) {
    @override
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'supermarket'),
      home: Consumer<AuthenticateProvider>(builder: (context1, authen, _) {
        final userProfile = authen.user;
        if (userProfile.firstname.length == 0) {
          return SplashScreen();
        }
        return Scaffold(
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
                          onPressed: () {
                            setState(() {
                              isUpdatePicture = !isUpdatePicture;
                            });
                          },
                          child: Stack(
                            children: [
                              Positioned(
                                  child: Container(
                                      width: width * 0.2,
                                      height: height * 0.2,
                                      child: CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(userProfile.picture),
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
                      isUpdatePicture
                          ? Column(
                              children: [
                                TextKT(text: 'อัพเดทรูปโปรไฟล์'),
                                Container(
                                  padding: EdgeInsets.only(top: 15),
                                  child: ChatInput(
                                    onchange: (text) {
                                      setState(() {
                                        // topicCheck = text;
                                      });
                                    },
                                    controller: updatePictureController,
                                    isCreate: true,
                                    title: 'โปรคใส่ลิงค์รูปภาพ...',
                                    color: whitePrimary,
                                    widthh: width * 0.9,
                                    heightt: height * 0.075,
                                    hasShadow: false,
                                  ),
                                ),
                                Container(
                                  width: width * 0.6,
                                  padding: EdgeInsets.all(20),
                                  child: Button(
                                    title: 'ยืนยัน',
                                    color: yellowPrimary,
                                    onPress: () {
                                      updatePic();
                                    },
                                  ),
                                )
                              ],
                            )
                          : Container(),
                      TextKT(text: 'บัญชี'),
                      TextBoxSetting(
                        title: 'บัญชี',
                        info: userProfile.email,
                      ),
                      TextBoxSetting(
                        title: 'ชื่อ',
                        info:
                            userProfile.firstname + " " + userProfile.lastname,
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
            ));
      }),
    );
  }
}

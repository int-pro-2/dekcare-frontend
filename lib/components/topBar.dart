import 'package:flutter/material.dart';
// import 'package:dekcare_frontend/Screens/Forum.dart';
// import 'package:dekcare_frontend/Screens/chat.dart';
// import 'package:dekcare_frontend/Screens/consult.dart';
import 'package:dekcare_frontend/Screens/landingScreen.dart';
import 'package:dekcare_frontend/components/constants.dart';

class TopBar extends StatelessWidget
// implements PreferredSizeWidget
{
  final String titleText;
  final press;
  final bool enableBackButton;
  final BuildContext contextFromPage;
  // Size get preferredSize => const Size.fromHeight(80);
  TopBar({
    this.press,
    required this.titleText,
    required this.enableBackButton,
    required this.contextFromPage,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        titleText,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      backgroundColor: yellowPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          if (enableBackButton == true) {
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return LandingScreen();
            // }));
            press();
            Navigator.pop(contextFromPage);
          }
        },
        tooltip: 'Back',
        splashColor:
            enableBackButton == true ? whitePrimary : Colors.transparent,
        color: enableBackButton == true ? Colors.white : Colors.transparent,
        enableFeedback: enableBackButton == true ? true : false,
      ),
    );
  }
}

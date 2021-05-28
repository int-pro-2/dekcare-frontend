import 'package:flutter/material.dart';
// import 'package:dekcare_frontend/Screens/Forum.dart';
// import 'package:dekcare_frontend/Screens/chat.dart';
// import 'package:dekcare_frontend/Screens/consult.dart';
import 'package:dekcare_frontend/Screens/landing.dart';
import 'package:dekcare_frontend/Components/constants.dart';

class TopBar extends StatelessWidget
// implements PreferredSizeWidget
{
  final String titleText;
  final bool enableBackButton;
  // Size get preferredSize => const Size.fromHeight(80);
  TopBar({
    required this.titleText,
    required this.enableBackButton,
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
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Landing();
            }));
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

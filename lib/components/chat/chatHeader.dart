import 'package:flutter/material.dart';
import 'package:dekcare_frontend/components/constants.dart';

class ChatHeader extends StatelessWidget
// implements PreferredSizeWidget
{
  final name, profile, press, contextFromPage;
  // Size get preferredSize => const Size.fromHeight(80);
  ChatHeader({this.name, this.profile, this.press, this.contextFromPage});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AppBar(
      toolbarHeight: height * 0.12,
      centerTitle: true,
      title: Container(
        height: height * 0.1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(profile),
              maxRadius: height * 0.035,
            ),
            Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            )
          ],
        ),
      ),
      backgroundColor: yellowPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            press();
            Navigator.pop(contextFromPage);
          },
          tooltip: 'Back'),
    );
  }
}

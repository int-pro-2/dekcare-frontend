import 'package:dekcare_frontend/Screens/mainChatScreen.dart';
import 'package:dekcare_frontend/provider/authenticateProvider.dart';
import 'package:dekcare_frontend/screens/forumScreen.dart';
import 'package:dekcare_frontend/screens/consultScreen.dart';
import 'package:dekcare_frontend/screens/landingScreen.dart';
import 'package:flutter/material.dart';
import 'package:dekcare_frontend/components/constants.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:provider/provider.dart';

class Nav extends StatefulWidget {
  final int currentIndex;
  @override
  const Nav({required this.currentIndex});

  _State createState() => _State();
}

class _State extends State<Nav> {
  @override
  int _currentIndex = 0;
  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    _pageController = PageController();

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    List<Widget> pageRoutes = [
      LandingScreen(),
      ConsultScreen(),
      ForumScreen(),
      MainChatScreen()
    ];

    List<BottomNavyBarItem> items = [
      BottomNavyBarItem(
        icon: Icon(Icons.home),
        title: Center(child: Text('Home')),
        activeColor: yellowPrimary,
      ),
      BottomNavyBarItem(
          icon: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/doctorIcon.png'),
            )),
          ),
          title: Center(
            child: Text(
              'Consult',
            ),
          ),
          activeColor: yellowPrimary),
      BottomNavyBarItem(
          icon: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/Forum.png'),
            )),
          ),
          title: Center(child: Text('Forum')),
          activeColor: yellowPrimary),
      BottomNavyBarItem(
          icon: Icon(Icons.chat),
          title: Center(child: Text('Chat')),
          activeColor: yellowPrimary),
    ];

    return Consumer<AuthenticateProvider>(builder: (context, authen, child) {
      final userProfile = authen.user;
      return Container(
        height: 60,
        child: PageView(controller: _pageController, children: [
          BottomNavyBar(
            selectedIndex: widget.currentIndex,
            showElevation: true,
            onItemSelected: (index) => setState(() {
              if (index != widget.currentIndex) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return pageRoutes[index];
                    },
                  ),
                );
              }

              _currentIndex = index;
              _pageController.animateToPage(index,
                  duration: Duration(milliseconds: 300), curve: Curves.ease);
            }),
            items: items,
          ),
        ]),
      );
    });
  }
}

import 'package:dekcare_frontend/Screens/Forum.dart';
import 'package:dekcare_frontend/Screens/chat.dart';
import 'package:dekcare_frontend/Screens/consult.dart';
import 'package:dekcare_frontend/Screens/landing.dart';
import 'package:flutter/material.dart';
import 'package:dekcare_frontend/Components/constants.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

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
    return Container(
      height: 60,
      child: PageView(controller: _pageController, children: [
        BottomNavyBar(
          selectedIndex: widget.currentIndex,
          showElevation: true,
          onItemSelected: (index) => setState(() {
            if (index == 0 && widget.currentIndex != 0)
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Landing();
                  },
                ),
              );
            if (index == 1 && widget.currentIndex != 1)
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Consult();
                  },
                ),
              );
            if (index == 2 && widget.currentIndex != 2)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Forum();
                  },
                ),
              );
            if (index == 3 && widget.currentIndex != 3)
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Chat();
                  },
                ),
              );

            _currentIndex = index;
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.ease);
          }),
          items: [
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
          ],
        ),
      ]),
    );
  }
}

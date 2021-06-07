import 'package:dekcare_frontend/Screens/transferMoney.dart';
import 'package:dekcare_frontend/components/errorCard.dart';
import 'package:dekcare_frontend/screens/individualChatScreen.dart';
import 'package:dekcare_frontend/Screens/transferMoney.dart';
import 'package:dekcare_frontend/components/Toggle.dart';
import 'package:dekcare_frontend/components/constants.dart';
import 'package:dekcare_frontend/components/consult/consultCard.dart';
import 'package:dekcare_frontend/components/navBar/nav.dart';
import 'package:dekcare_frontend/components/topBar.dart';
import 'package:dekcare_frontend/provider/chatProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsultScreen extends StatefulWidget {
  bool fav = false;
  bool privilege = false;
  @override
  _ConsultState createState() => _ConsultState();
}

class _ConsultState extends State<ConsultScreen> {
  bool isLoading = true;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      isLoading = true;
    });
    ListDoctor(widget.fav);
    return null;
  }

  void changeFav(newFav) {
    setState(() {
      widget.fav = newFav;
    });
    ListDoctor(widget.fav);
  }

  void ListDoctor(bool isFav) async {
    try {
      print(isFav);
      await Provider.of<ChatProvider>(context, listen: false)
          .getListOfDoctor(isFav);
    } catch (err) {
      print(err);
    }
    setState(() {
      isLoading = false;
    });
  }

  Widget renderDoctorList(height) {
    return Consumer<ChatProvider>(builder: (context, value, child) {
      final doctorList = value.doctorList;
      return isLoading
          ? Container(
              height: height * 0.6,
              child: Center(
                child:
                    CircularProgressIndicator(backgroundColor: yellowPrimary),
              ),
            )
          : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: doctorList.length,
              itemBuilder: (context, index) => consultCard(
                  id: doctorList[index].id,
                  name: doctorList[index].firstname +
                      " " +
                      doctorList[index].lastname,
                  profile: doctorList[index].picture,
                  hospital: doctorList[index].hospital,
                  isFavorite: doctorList[index].isFav,
                  refresher: () {
                    ListDoctor(widget.fav);
                  },
                  press: () {
                    print('navigate');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return IndividualChatScreen(
                        id: doctorList[index].id,
                        name: doctorList[index].firstname +
                            " " +
                            doctorList[index].lastname,
                        picture: doctorList[index].picture,
                      );
                    }));
                  }));
    });
  }

  @override
  void initState() {
    isLoading = true;
    ListDoctor(widget.fav);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'supermarket'),
      home: Scaffold(
        appBar: PreferredSize(
          child: TopBar(
            titleText: 'ปรึกษาลูกน้อยกับหมอ',
            enableBackButton: false,
            contextFromPage: context,
          ),
          preferredSize: Size.fromHeight((height * 0.075)),
        ),
        bottomNavigationBar: Nav(
          currentIndex: 1,
        ),
        backgroundColor: greySecondary,
        body: SafeArea(
            child: Center(
          child: widget.privilege
              ? Column(children: [
                  Toggle(
                    button1Title: 'ค้นหาหมอ',
                    button2Title: 'หมอติดดาว',
                    current: widget.fav,
                    onChange: changeFav,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 10.0),
                  //   child: Container(
                  //     width: width * 0.92,
                  //     child: searchBar(title: 'ค้นหาชื่อคุณหมอที่นี่'),
                  //   ),
                  // ),
                  Expanded(
                      child: RefreshIndicator(
                          key: refreshKey,
                          onRefresh: refreshList,
                          color: yellowPrimary,
                          child: SingleChildScrollView(
                            child: renderDoctorList(height),
                          ))),
                ])
              : errorCard(
                  width: width,
                  height: height,
                  page: () => TransferMoneyScreen),
        )),
      ),
    );
  }
}

// ListView.builder(
// physics: NeverScrollableScrollPhysics(),
// shrinkWrap: true,
// itemCount: 3,
// itemBuilder: (context, index) => consultCard(
// name: doctorList[i].firstname +
//     " " +
//     doctorList[i].lastname,
// profile: doctorList[i].picture,
// hospital: doctorList[i].hospital,
// isFavorite: doctorList[i].isFav,
// press: () {
//   print('navigate');
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) {
//         return LandingScreen();
//       },
//     ),
//   );
// }))
// ),

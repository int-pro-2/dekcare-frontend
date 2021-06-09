import 'package:dekcare_frontend/components/errorCard.dart';
import 'package:dekcare_frontend/provider/authenticateProvider.dart';
import 'package:dekcare_frontend/provider/forumProvider.dart';
import 'package:dekcare_frontend/screens/individualChatScreen.dart';
import 'package:dekcare_frontend/components/Toggle.dart';
import 'package:dekcare_frontend/components/constants.dart';
import 'package:dekcare_frontend/components/consult/consultCard.dart';
import 'package:dekcare_frontend/components/navBar/nav.dart';
import 'package:dekcare_frontend/components/topBar.dart';
import 'package:dekcare_frontend/provider/chatProvider.dart';
import 'package:dekcare_frontend/screens/splashScreen.dart';
import 'package:dekcare_frontend/screens/transferMoney.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsultScreen extends StatefulWidget {
  bool fav = false;
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

  Future<void> ListDoctor(bool isFav) async {
    try {
      await Provider.of<ChatProvider>(context, listen: false)
          .getListOfDoctor(isFav);
    } catch (err) {
      print(err);
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchUserProfile() async {
    try {
      await Provider.of<AuthenticateProvider>(context, listen: false)
          .fetchProfile();
    } catch (error) {}
  }

  Widget renderDoctorList(width, height, userProfile) {
    return Consumer<AuthenticateProvider>(builder: (context, authen, child) {
      return Consumer<ChatProvider>(builder: (context, value, child) {
        final doctorList = value.doctorList;
        return authen.user.privilege
            ? Column(children: [
                Toggle(
                  button1Title: 'ค้นหาหมอ',
                  button2Title: 'หมอติดดาว',
                  current: widget.fav,
                  onChange: changeFav,
                ),
                Expanded(
                    child: RefreshIndicator(
                        key: refreshKey,
                        onRefresh: refreshList,
                        color: yellowPrimary,
                        child: SingleChildScrollView(
                          child: isLoading
                              ? Container(
                                  height: height * 0.6,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                        backgroundColor: yellowPrimary),
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
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return IndividualChatScreen(
                                            id: doctorList[index].id,
                                            name: doctorList[index].firstname +
                                                " " +
                                                doctorList[index].lastname,
                                            picture: doctorList[index].picture,
                                          );
                                        }));
                                      })),
                        ))),
              ])
            : errorCard(
                width: width,
                height: height,
                page: TransferMoneyScreen(userProfile[0].money));
      });
    });
  }

  Future<void> fetchData() async {
    isLoading = true;
    await ListDoctor(widget.fav);
    await fetchUserProfile();
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'supermarket'),
        home: Consumer<AuthenticateProvider>(builder: (context, authen, _) {
          final userProfile = authen.user;
          if (userProfile.firstname.length == 0) {
            return SplashScreen();
          }
          return Container(
            color: yellowPrimary,
            child: SafeArea(
              child: Scaffold(
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
                    child: renderDoctorList(width, height, userProfile),
                  ))),
            ),
          );
        }));
  }
}

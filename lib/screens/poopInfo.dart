import 'package:dekcare_frontend/components/cardPoopInfo.dart';
import 'package:dekcare_frontend/components/constants.dart';
import 'package:dekcare_frontend/components/topBar.dart';
import 'package:dekcare_frontend/provider/poopProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PoopInfo extends StatefulWidget {
  @override
  _PoopInfoState createState() => _PoopInfoState();
}

class _PoopInfoState extends State<PoopInfo> {
  bool _isLoading = false;
  void fetchData() async {
    try {
      setState(() => _isLoading = true);
      await Provider.of<PoopProvider>(context, listen: false)
          .fetchPoopInfo(6, 2021);
      setState(() => _isLoading = false);
    } catch (error) {
      print(error);
    }
  }

  void initState() {
    fetchData();
    super.initState();
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      theme: ThemeData(fontFamily: 'supermarket'),
      home: SafeArea(
        child: Scaffold(
          backgroundColor: greySecondary,
          appBar: PreferredSize(
            child: TopBar(
              titleText: 'ข้อมูลสุขภาพอุจจาระของลูก',
              enableBackButton: true,
              contextFromPage: context,
              press: () => {},
            ),
            preferredSize: Size.fromHeight((height * 0.075)),
          ),
          body: Consumer<PoopProvider>(builder: (context, poopProvider, _) {
            List<PoopInfoItem> poops = poopProvider.poopsInfo;
            print(poops.length);
            return Container(
              padding: const EdgeInsets.all(20),
              width: width,
              height: height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Text('calendar'),
                    ),
                    _isLoading
                        ? Container(
                            height: height * 0.6,
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: yellowPrimary,
                              ),
                            ),
                          )
                        : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: poops.length,
                            itemBuilder: (ctx, index) {
                              return CardPoopInfo(data: poops[index]);
                            },
                          ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

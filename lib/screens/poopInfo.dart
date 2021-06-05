import 'package:dekcare_frontend/components/cardPoopInfo.dart';
import 'package:dekcare_frontend/components/constants.dart';

import 'package:month_picker_dialog/month_picker_dialog.dart';
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
  DateTime selectedDate = new DateTime.now();
  void fetchData() async {
    try {
      setState(() => _isLoading = true);
      await Provider.of<PoopProvider>(context, listen: false)
          .fetchPoopInfo(selectedDate.month, selectedDate.year);
      setState(() => _isLoading = false);
    } catch (error) {
      print(error);
    }
  }

  void initState() {
    fetchData();
    print(selectedDate.month.toString());
    super.initState();
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      theme: ThemeData(fontFamily: 'supermarket'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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

          return Container(
            padding: const EdgeInsets.all(20),
            width: width,
            height: height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      showMonthPicker(
                        context: context,
                        firstDate: DateTime(DateTime.now().year - 1, 5),
                        lastDate: DateTime(DateTime.now().year + 1, 9),
                        initialDate: selectedDate,
                        locale: Locale("th"),
                      ).then((date) {
                        if (date != null) {
                          setState(() {
                            selectedDate = date;
                          });
                          fetchData();
                        }
                      });
                    },
                    child: Container(
                      width: width,
                      height: height * 0.08,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                selectedDate.month.toString() +
                                    '/' +
                                    selectedDate.year.toString(),
                                style: TextStyle(fontSize: 18),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
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
    );
  }
}

import 'package:dekcare_frontend/components/button.dart';
import 'package:dekcare_frontend/components/constants.dart';
import 'package:dekcare_frontend/components/topBar.dart';
import 'package:dekcare_frontend/components/text.dart';
import 'package:flutter/material.dart';

class PoopInputScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final TextEditingController typeController = TextEditingController();
    final TextEditingController colorController = TextEditingController();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      theme: ThemeData(fontFamily: 'supermarket'),
      home: Scaffold(
          backgroundColor: greySecondary,
          bottomNavigationBar: Container(
            height: height * 0.09,
            color: whitePrimary,
            child: Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              child:
                  Button(title: 'ยืนยัน', color: greyPrimary, onPress: () {}),
            ),
          ),
          appBar: PreferredSize(
              child: TopBar(
                titleText: 'สุขภาพอุจจาระของลูก',
                enableBackButton: true,
                contextFromPage: context,
              ),
              preferredSize: Size.fromHeight((height * 0.075))),
          body: Container(
            height: height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: width * 0.5,
                        child: Column(
                          children: [
                            TextKT(text: 'วันที่บันทึก'),
                            Container(
                              width: width * 0.4,
                              height: height * 0.06,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  primary: blackSecondaryFont,
                                  backgroundColor: whitePrimary,
                                ),
                                onPressed: () {},
                                child: Text(
                                  DateTime.now().toString().substring(0, 10),
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: width * 0.5,
                        child: Column(
                          children: [
                            TextKT(text: 'วันที่บันทึก'),
                            Container(
                              width: width * 0.4,
                              height: height * 0.06,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  primary: blackSecondaryFont,
                                  backgroundColor: whitePrimary,
                                ),
                                onPressed: () {},
                                child: Text(
                                  DateTime.now().toString().substring(11, 16),
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  TextKT(text: 'ลักษณะของอุจจาระ'),
                  Container(
                    width: width * 0.9,
                    child: DropdownButtonFormField<String>(
                      items: <String>[
                        'ก้อนเม็ดเล็กๆ',
                        'ก้อนแข็งมีรอยแตก',
                        'ก้อนแข็ง',
                        'เป็นก้อน',
                        'อ่อนนิ่ม',
                        'เหลว',
                        'เหลวเป็นน้ำ'
                      ].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (_) {},
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'เลือกลักษณะของอุจจาระ',
                        fillColor: whitePrimary,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextKT(text: 'ลักษณะของอุจจาระ'),
                  Container(
                    width: width * 0.9,
                    child: DropdownButtonFormField<String>(
                      items: <String>[
                        'ดำ',
                        'ขาวเทา/เหลืองซีด',
                        'น้ำตาล',
                        'ส้ม',
                        'เหลือง',
                        'เขียว',
                        'แดง'
                      ].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (_) {},
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'เลือกลักษณะของอุจจาระ',
                        fillColor: whitePrimary,
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

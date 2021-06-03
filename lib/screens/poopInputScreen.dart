import 'package:date_format/date_format.dart';
import 'package:dekcare_frontend/components/button.dart';
import 'package:dekcare_frontend/components/constants.dart';
import 'package:dekcare_frontend/components/topBar.dart';
import 'package:dekcare_frontend/components/text.dart';
import 'package:dekcare_frontend/provider/poopProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class PoopInputScreen extends StatefulWidget {
  @override
  _PoopInputScreenState createState() => _PoopInputScreenState();
}

String color = '';
String type = '';

class _PoopInputScreenState extends State<PoopInputScreen> {
  void fetchData() async {
    try {
      print('from screen');
      await Provider.of<PoopProvider>(context, listen: false).fetchData();
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    fetchData();
    _dateController.text = DateTime.now().toString();
    _timeController.text = DateTime.now().hour.toString() +
        ' : ' +
        DateTime.now().minute.toString();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String _setTime = "", _setDate = "";

  String _hour = "", _minute = "", _time = "";

  String dateTime = "";

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = selectedDate.toString();
        print(selectedDate.toString());
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
      });
      print(_hour);
      print(_minute);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MaterialApp(
      theme: ThemeData(fontFamily: 'supermarket'),
      home: SafeArea(
        child: Scaffold(
            backgroundColor: greySecondary,
            bottomNavigationBar: Container(
              height: height * 0.09,
              color: whitePrimary,
              child: Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Button(
                    title: 'ยืนยัน',
                    color: (type != '' && color != '')
                        ? yellowPrimary
                        : greyPrimary,
                    onPress: () {
                      print(type + color);
                    }),
              ),
            ),
            appBar: PreferredSize(
                child: TopBar(
                  press: () {
                    setState(() {
                      color = '';
                      type = '';
                    });
                  },
                  titleText: 'สุขภาพอุจจาระของลูก',
                  enableBackButton: true,
                  contextFromPage: context,
                ),
                preferredSize: Size.fromHeight((height * 0.075))),
            body: Consumer<PoopProvider>(builder: (context, poopProvider, _) {
              List<PoopColor> colors = poopProvider.colors;
              List<PoopType> types = poopProvider.types;
              String getRenderTime() {
                List<String> temp =
                    selectedDate.toString().substring(0, 10).split("-");
                return temp[2] + '/' + temp[1] + '/' + temp[0];
              }

              return Container(
                height: height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: width * 0.5,
                            child: Column(
                              children: [
                                const TextKT(text: 'วันที่บันทึก'),
                                Container(
                                  width: width * 0.4,
                                  height: height * 0.06,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      primary: blackSecondaryFont,
                                      backgroundColor: whitePrimary,
                                    ),
                                    onPressed: () {
                                      _selectDate(context);
                                    },
                                    child: Text(
                                      getRenderTime(),
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
                                const TextKT(text: 'เวลาที่บันทึก'),
                                Container(
                                  width: width * 0.4,
                                  height: height * 0.06,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      primary: blackSecondaryFont,
                                      backgroundColor: whitePrimary,
                                    ),
                                    onPressed: () {
                                      _selectTime(context);
                                    },
                                    child: Text(
                                      _timeController.text,
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const TextKT(text: 'ลักษณะของอุจจาระ'),
                      Container(
                        width: width * 0.9,
                        child: DropdownButtonFormField<String>(
                          items: types.map((PoopType el) {
                            return new DropdownMenuItem<String>(
                              value: el.id.toString(),
                              child: Text(el.text),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() => type = value.toString());
                          },
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'เลือกลักษณะของอุจจาระ',
                            fillColor: whitePrimary,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const TextKT(text: 'สีของอุจจาระ'),
                      Container(
                        width: width * 0.9,
                        child: DropdownButtonFormField<String>(
                          items: colors.map((PoopColor el) {
                            return DropdownMenuItem<String>(
                              value: el.id.toString(),
                              child: Text(el.color),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() => color = value.toString());
                          },
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'เลือกสีของอุจจาระ',
                            fillColor: whitePrimary,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })),
      ),
    );
  }
}

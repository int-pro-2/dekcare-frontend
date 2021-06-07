import 'package:dekcare_frontend/components/button.dart';
import 'package:dekcare_frontend/components/chatInput.dart';
import 'package:dekcare_frontend/components/constants.dart';
import 'package:dekcare_frontend/components/text.dart';
import 'package:dekcare_frontend/provider/authenticateProvider.dart';
import 'package:dekcare_frontend/screens/landingScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class TransferMoneyScreen extends StatefulWidget {
  @override
  final money;
  TransferMoneyScreen(this.money);
  _TransferMoneyScreenState createState() => _TransferMoneyScreenState();
}

class _TransferMoneyScreenState extends State<TransferMoneyScreen> {
  @override
  int amount = 0;
  var bankID = '';
  String type = '';

  var amountCheckError = 0;
  var typeCheckError = '';

  var bankIDCheckError = '';

  void transferMoney() async {
    print('addmoney' + amountController.text);
    try {
      await Provider.of<AuthenticateProvider>(context, listen: false)
          .transferMoney(
              int.parse(amountController.text), bankIDController.text);
      Navigator.pop(context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LandingScreen();
          },
        ),
      );
    } catch (error) {
      print(error);
    }
  }

  final TextEditingController amountController = TextEditingController();
  final TextEditingController bankIDController = TextEditingController();
  Widget build(BuildContext context) {
    @override
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(widget.money);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'supermarket'),
      home: Scaffold(
        backgroundColor: greySecondary,
        bottomNavigationBar: Container(
          height: height * 0.09,
          color: whitePrimary,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Button(
              title: 'ยืนยัน',
              color: (type != '') ? yellowPrimary : greyPrimary,
              onPress: () {
                if (type == '') {
                  setState(() {
                    typeCheckError = 'error';
                  });
                }

                if (type.contains('30')) {
                  transferMoney();
                }
                if (type.contains('150')) {
                  transferMoney();
                }
                if (type.contains('500')) {
                  transferMoney();
                }
              },
            ),
          ),
        ),
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text(
              'สมัครสมาชิกโปรโมชั่น',
              style: TextStyle(fontSize: 23),
            ),
            centerTitle: true,
            backgroundColor: yellowPrimary,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)))),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        width: width * 0.3,
                        child: TextKT(text: 'ยอดเงินคงเหลือ'),
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: width * 0.4,
                          ),
                          Container(
                            width: width * 0.3,
                            child: TextKT(text: widget.money + ' baht'),
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    width: width * 0.9,
                    child: DropdownButtonFormField<String>(
                      items: <String>[
                        'รายวัน 30 บาท',
                        'รายเดือน 150 บาท',
                        'รายปี 500 บาท',
                      ].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          type = value.toString();
                          typeCheckError = value.toString();
                        });
                        print(type);
                      },
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: whitePrimary, width: 0.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        hintText: 'เลือกโปรโมชั่น',
                        fillColor: whitePrimary,
                      ),
                    ),
                  ),
                  typeCheckError == 'error'
                      ? Container(
                          width: width,
                          padding: EdgeInsets.only(top: 20, left: 25),
                          child: Text(
                            'โปรดเลือกโปรโมชั่น',
                            style: TextStyle(fontSize: 18, color: Colors.red),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

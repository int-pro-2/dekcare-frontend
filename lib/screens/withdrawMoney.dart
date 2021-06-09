import 'package:dekcare_frontend/components/button.dart';
import 'package:dekcare_frontend/components/chatInput.dart';
import 'package:dekcare_frontend/components/constants.dart';
import 'package:dekcare_frontend/components/text.dart';
import 'package:dekcare_frontend/provider/authenticateProvider.dart';
import 'package:dekcare_frontend/screens/landingScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class WithdrawMoneyScreen extends StatefulWidget {
  @override
  final money;
  WithdrawMoneyScreen(this.money);
  _WithdrawMoneyScreenState createState() => _WithdrawMoneyScreenState();
}

class _WithdrawMoneyScreenState extends State<WithdrawMoneyScreen> {
  @override
  var amount = '';
  var bankID = '';
  String type = '';

  var amountCheckError = '';
  var typeCheckError = '';

  var bankIDCheckError = '';

  void addMoney() async {
    print('addmoney' + amountController.text);
    try {
      await Provider.of<AuthenticateProvider>(context, listen: false)
          .withdrawMoney(int.parse(amountController.text));
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
    print('done create forumm');
  }

  final TextEditingController amountController = TextEditingController();
  final TextEditingController bankIDController = TextEditingController();
  Widget build(BuildContext context) {
    @override
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(widget.money.toString());

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
              color: (type != '' && bankID != '' && amount != '')
                  ? yellowPrimary
                  : greyPrimary,
              onPress: () {
                if (type == '') {
                  setState(() {
                    typeCheckError = 'error';
                  });
                }

                if (amount == '') {
                  setState(() {
                    amountCheckError = 'error';
                  });
                }
                if (bankID == '') {
                  setState(() {
                    bankIDCheckError = 'error';
                  });
                }
                if (amount != '' && bankID != '' && type != '') {
                  addMoney();
                }
                if (amount == '' && bankID == '') {
                  print('topic and body are not complete');
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
              'ถอนเงิน',
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
                            child:
                                TextKT(text: widget.money.toString() + ' baht'),
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
                        'ธนาคารกสิกร',
                        'ธนาคารไทยพาณิชย์',
                        'ธนาคารกรุงเทพ',
                        'ธนาคารกรุงไทย',
                        'prompay',
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
                        hintText: 'ธนาคาร',
                        fillColor: whitePrimary,
                      ),
                    ),
                  ),
                  typeCheckError == 'error'
                      ? Container(
                          width: width,
                          padding: EdgeInsets.only(top: 20, left: 25),
                          child: Text(
                            'โปรดเลือกธนาคาร',
                            style: TextStyle(fontSize: 18, color: Colors.red),
                          ),
                        )
                      : Container(),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: ChatInput(
                      controller: bankIDController,
                      isCreate: true,
                      onchange: (text) {
                        setState(() {
                          bankID = text;
                        });
                        setState(() {
                          bankIDCheckError = '';
                        });
                      },
                      title: 'เลขที่บัญชี',
                      color: whitePrimary,
                      widthh: width * 0.9,
                      heightt: height * 0.07,
                      hasShadow: false,
                    ),
                  ),
                  bankIDCheckError == 'error'
                      ? Container(
                          width: width,
                          padding: EdgeInsets.only(top: 20, left: 25),
                          child: Text(
                            'โปรดระบุเลขที่บัญชี',
                            style: TextStyle(fontSize: 18, color: Colors.red),
                          ),
                        )
                      : Container(),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: ChatInput(
                      controller: amountController,
                      isCreate: true,
                      onchange: (text) {
                        setState(() {
                          amount = text;
                        });
                        setState(() {
                          amountCheckError = '';
                        });
                      },
                      title: 'จำนวนเงิน',
                      color: whitePrimary,
                      widthh: width * 0.9,
                      heightt: height * 0.07,
                      hasShadow: false,
                    ),
                  ),
                  amountCheckError == 'error'
                      ? Container(
                          width: width,
                          padding: EdgeInsets.only(top: 20, left: 25),
                          child: Text(
                            'โปรดระบุจำนวนเงิน',
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

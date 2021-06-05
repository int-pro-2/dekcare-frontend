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
              color:
                  (bankID != '' && amount != 0) ? yellowPrimary : greyPrimary,
              onPress: () {
                if (type == '') {
                  setState(() {
                    typeCheckError = 'error';
                  });
                }

                if (amount == 0) {
                  setState(() {
                    amountCheckError = -1;
                  });
                }
                if (bankID == '') {
                  setState(() {
                    bankIDCheckError = 'error';
                  });
                }
                if (amount != 0 && bankID != '') {
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
                            child: TextKT(text: widget.money + ' baht'),
                          )
                        ],
                      ),
                    ],
                  ),
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
                      title: 'บัญชีผู้ใช้',
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
                            'โปรดระบุบัญชีผู้ใช้',
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
                          if (text != '') {
                            amount = int.parse(text);
                          } else {
                            amount = 0;
                          }
                        });
                        setState(() {
                          amountCheckError = 0;
                        });
                        print(amount.toString() + 'amonut');
                      },
                      title: 'จำนวนเงิน',
                      color: whitePrimary,
                      widthh: width * 0.9,
                      heightt: height * 0.07,
                      hasShadow: false,
                    ),
                  ),
                  amountCheckError == -1
                      ? Container(
                          width: width,
                          padding: EdgeInsets.only(top: 20, left: 25),
                          child: Text(
                            'โปรดระบุจำนวนเงิน',
                            style: TextStyle(fontSize: 18, color: Colors.red),
                          ),
                        )
                      : Container(),
                  amount > int.parse(widget.money)
                      ? Container(
                          width: width,
                          padding: EdgeInsets.only(top: 20, left: 25),
                          child: Text(
                            'จำนวนเงินคงเหลือมีไม่เพียงพอ',
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

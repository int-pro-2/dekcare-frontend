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

class Choice {
  final String text;
  final int amount;
  Choice({required this.text, required this.amount});
}

class _TransferMoneyScreenState extends State<TransferMoneyScreen> {
  @override
  int amount = 0;
  var bankID = '';
  String type = '';

  var amountCheckError = 0;
  var typeCheckError = '';

  var bankIDCheckError = '';
  List<Choice> choices = [
    Choice(text: 'รายวัน 30 บาท', amount: 30),
    Choice(text: 'รายเดือน 150 บาท', amount: 150),
    Choice(text: 'รายปี 500 บาท', amount: 500)
  ];

  void transferMoney() async {
    try {
      print(amount);
      await Provider.of<AuthenticateProvider>(context, listen: false)
          .subscribe(amount);
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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'supermarket'),
      home: Scaffold(
        backgroundColor: greySecondary,
        bottomNavigationBar: Container(
          height: height * 0.09,
          color: whitePrimary,
          child: Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Button(
              title: 'ยืนยัน',
              color: (amount != 0) ? yellowPrimary : greyPrimary,
              onPress: () {
                if (amount == 0) {
                  setState(() => typeCheckError = 'error');
                } else {
                  transferMoney();
                }
              },
            ),
          ),
        ),
        appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text(
              'สมัครสมาชิกโปรโมชั่น',
              style: TextStyle(fontSize: 23),
            ),
            centerTitle: true,
            backgroundColor: yellowPrimary,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)))),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        width: width * 0.3,
                        child: const TextKT(text: 'ยอดเงินคงเหลือ'),
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
                      items: choices.map((Choice value) {
                        return new DropdownMenuItem<String>(
                          value: value.amount.toString(),
                          child: Text(value.text),
                        );
                      }).toList(),
                      onChanged: (el) {
                        setState(() => amount = int.parse(el.toString()));
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

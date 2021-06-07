import 'package:flutter/material.dart';

import 'constants.dart';

class errorCard extends StatelessWidget {
  final width, height, page;
  const errorCard({this.height, this.width, this.page});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height * 0.80,
        width: width * 0.85,
        child: Center(
          child: Container(
            height: 220,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Icon(
                      Icons.lock_outline_rounded,
                      color: yellowPrimary,
                      size: 40,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "การเข้าถึงถูกปฏิเสธเนื่องจากสิทธิ์ของคุณหมดอายุหรือไม่เพียงพอ ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20, color: yellowPrimary, height: 1.15),
                    ),
                  ),
                  ElevatedButton(
                      child: Text("กลับสู่หน้าหลัก",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return yellowPrimary;
                          },
                        ),
                        elevation: MaterialStateProperty.resolveWith<double>(
                            (Set<MaterialState> states) {
                          return 0;
                        }),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return page;
                            },
                          ),
                        );
                      })
                ],
              ),
            ),
            decoration: BoxDecoration(
                color: whitePrimary, borderRadius: BorderRadius.circular(15)),
          ),
        ));
  }
}

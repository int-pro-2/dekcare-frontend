import 'package:dekcare_frontend/Screens/consultScreen.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class EmptyCard extends StatelessWidget {
  final pevContext;
  const EmptyCard({this.pevContext});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: new GestureDetector(
        child: Container(
          child: Container(
            height: 125,
            width: width * 0.95,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text("ค้นหาหมอที่ต้องการแชท",
                      style: TextStyle(color: greyPrimary, fontSize: 18)),
                ),
                Icon(
                  Icons.add_circle_outline,
                  color: greyPrimary,
                  size: 33,
                )
              ],
            ),
            decoration: DottedDecoration(
                borderRadius: BorderRadius.circular(20),
                shape: Shape.box,
                strokeWidth: 2.5,
                color: greyPrimary),
          ),
          decoration: BoxDecoration(
              color: whitePrimary, borderRadius: BorderRadius.circular(20)),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ConsultScreen();
          }),
        ),
      ),
    );
  }
}

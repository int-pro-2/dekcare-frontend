// import 'package:dekcare_frontend/Screens/consultScreen.dart';
// import 'package:dotted_decoration/dotted_decoration.dart';
// import 'package:flutter/material.dart';

// import '../constants.dart';

// class EmptyCard extends StatelessWidget {
//   final pevContext;
//   const EmptyCard({this.pevContext});

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Container(
//         child: Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: Container(
//         height: 125,
//         width: width * 0.95,
//         child: MaterialButton(
//           color: whitePrimary,
//           child: Column(
//             children: [],
//           ),
//           shape:

//           ),

//           child: DecoratedBox(
//             decoration: BoxDecoration(
//                 color: whitePrimary,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                       color: Color(0x19000000),
//                       blurRadius: 4,
//                       offset: Offset(0, 4))
//                 ]),
//           ),
//           onPressed: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context) {
//               return ConsultScreen();
//             }));
//           },
//         ),
//       ),
//     ));
//   }
// }

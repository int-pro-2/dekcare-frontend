import 'package:dekcare_frontend/components/button.dart';
import 'package:dekcare_frontend/components/text.dart';
import 'package:dekcare_frontend/model/hexColor.dart';
import 'package:dekcare_frontend/provider/poopProvider.dart';
import 'package:flutter/material.dart';
import 'package:dekcare_frontend/components/constants.dart';

class CardPoopInfo extends StatefulWidget {
  final PoopInfoItem data;
  CardPoopInfo({required this.data});
  @override
  State<CardPoopInfo> createState() => _CardPoopInfoState();
}

class _CardPoopInfoState extends State<CardPoopInfo> {
  bool _isExpanded = false;

  Widget buildInfo(BuildContext context) {
    if (_isExpanded) {
      return Container(
        // color: Colors.red,
        padding: const EdgeInsets.only(left: 25),
        child: Column(
          children: [
            ...widget.data.poops
                .map(
                  (e) => Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 10, top: 0),
                        width: 30,
                        child: CircleAvatar(
                          backgroundColor: HexColor(e.code),
                        ),
                      ),
                      Text(
                        e.text,
                        style: TextStyle(
                            fontFamily: 'supermarket',
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                )
                .toList()
          ],
        ),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: Container(
        width: width * 0.9,
        margin: EdgeInsets.only(top: 20),
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(23),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                ),
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.03),
              Container(
                padding: EdgeInsets.only(left: 20),
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.data.date,
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Row(
                        children: [
                          ...widget.data.poops
                              .map(
                                (e) => Container(
                                  padding: const EdgeInsets.only(right: 10),
                                  width: 30,
                                  child: CircleAvatar(
                                    backgroundColor: HexColor(e.code),
                                  ),
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              buildInfo(context),
              // Row(
              //   children: [
              // Container(
              //   padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
              //   width: 100,
              //   child: const CircleAvatar(
              //     backgroundColor: yellowPrimary,
              //   ),
              // ),
              //     Container(
              //       padding: const EdgeInsets.only(top: 20, right: 20),
              //       child: Text(
              //         'เหลว+เหลือง',
              //         style: const TextStyle(fontSize: 18),
              //       ),
              //     ),
              //   ],
              // ),
              // Row(
              //   children: [
              //     Container(
              //       padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
              //       width: 100,
              //       child: const CircleAvatar(
              //         backgroundColor: yellowPrimary,
              //       ),
              //     ),
              //     Container(
              //       padding: EdgeInsets.only(top: 20, right: 20),
              //       child: Text(
              //         'เหลว+เหลือง',
              //         style: TextStyle(fontSize: 18),
              //       ),
              //     ),
              //   ],
              // ),
              Container(
                padding: const EdgeInsets.only(left: 25, top: 5, bottom: 15),
                width: width,
                child: widget.data.poops.length == 0
                    ? Text(
                        'ไม่มีข้อมูล',
                        style: TextStyle(
                            fontFamily: 'supermarket',
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              widget.data.result,
                              style: TextStyle(
                                fontFamily: 'supermarket',
                                fontSize: 20,
                                color: HexColor(widget.data.resultCode),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          _isExpanded
                              ? IconButton(
                                  padding: EdgeInsets.only(top: 0, right: 20),
                                  constraints: BoxConstraints(),
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.arrow_drop_up,
                                    size: 40,
                                  ),
                                )
                              : IconButton(
                                  padding: EdgeInsets.only(top: 0, right: 20),
                                  constraints: BoxConstraints(),
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    size: 40,
                                  ),
                                ),
                        ],
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

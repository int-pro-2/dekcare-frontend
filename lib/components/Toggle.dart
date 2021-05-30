import 'package:dekcare_frontend/components/constants.dart';
import 'package:flutter/material.dart';

class Toggle extends StatefulWidget {
  final String button1Title;
  final String button2Title;
  bool status1 = true;
  bool status2 = false;

  Toggle({required this.button1Title, required this.button2Title});

  @override
  _ToggleState createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Container(
          width: width * 0.91,
          height: height * 0.045,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: width * 0.35,
                child: ElevatedButton(
                  child: Text(
                    widget.button1Title,
                    style: TextStyle(
                        color: widget.status1 == true
                            ? whitePrimary
                            : yellowPrimary,
                        fontSize: 18),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(color: yellowPrimary, width: 2))),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed) ||
                            widget.status1 == true) return yellowPrimary;
                        return widget.status1 == true
                            ? yellowPrimary
                            : Colors
                                .transparent; // Use the component's default.
                      },
                    ),
                    shadowColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return Colors
                            .transparent; // Use the component's default.
                      },
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      widget.status1 = !widget.status1;
                      widget.status2 = !widget.status2;
                    });
                  },
                ),
              ),
              Container(
                width: width * 0.35,
                child: ElevatedButton(
                  child: Text(
                    widget.button2Title,
                    style: TextStyle(
                        color: widget.status2 == true
                            ? whitePrimary
                            : yellowPrimary,
                        fontSize: 18),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(color: yellowPrimary, width: 2))),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed) ||
                            widget.status2 == true) return yellowPrimary;
                        return widget.status2 == true
                            ? yellowPrimary
                            : Colors
                                .transparent; // Use the component's default.
                      },
                    ),
                    shadowColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return Colors
                            .transparent; // Use the component's default.
                      },
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      widget.status2 = !widget.status2;
                      widget.status1 = !widget.status1;
                    });
                  },
                ),
              ),
            ],
          )),
    );
  }
}

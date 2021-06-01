import 'package:dekcare_frontend/components/constants.dart';
import 'package:flutter/material.dart';

class Toggle extends StatefulWidget {
  final String button1Title;
  final String button2Title;
  final bool current;
  final Function onChange;

  Toggle(
      {required this.button1Title,
      required this.button2Title,
      required this.current,
      required this.onChange});

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
                        color: widget.current == false
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
                            widget.current == false) return yellowPrimary;
                        return widget.current == false
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
                    widget.onChange(!widget.current);
                  },
                ),
              ),
              Container(
                width: width * 0.35,
                child: ElevatedButton(
                  child: Text(
                    widget.button2Title,
                    style: TextStyle(
                        color: widget.current == true
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
                            widget.current == true) return yellowPrimary;
                        return widget.current == true
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
                    widget.onChange(!widget.current);
                  },
                ),
              ),
            ],
          )),
    );
  }
}

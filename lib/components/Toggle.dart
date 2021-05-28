import 'package:dekcare_frontend/Components/constants.dart';
import 'package:flutter/material.dart';

class Toggle extends StatefulWidget {
  final String button1Title;
  final String button2Title;

  List<bool> _selections = [true, false];

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
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        width: width * 0.91,
        height: height * 0.035,
        child: ToggleButtons(
          children: <Widget>[
            Container(
              width: width * 0.45,
              alignment: Alignment.center,
              child: Text(widget.button1Title),
            ),
            Container(
              width: width * 0.45,
              alignment: Alignment.center,
              child: Text(widget.button2Title),
            )
          ],
          isSelected: widget._selections,
          color: yellowPrimary,
          selectedColor: whitePrimary,
          fillColor: yellowPrimary,
          splashColor: yellowPrimary,
          onPressed: (int index) {
            if (widget._selections[0] != widget._selections[1]) {
              setState(() {
                widget._selections[index] = !widget._selections[index];
                widget._selections[(index + 1) % 2] =
                    !widget._selections[(index + 1) % 2];
              });
            }
          },
        ),
      ),
    );
  }
}

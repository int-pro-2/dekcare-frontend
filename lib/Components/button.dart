import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final onPress;
  final String title;
  final Color color;

  Button({required this.color, required this.onPress, required this.title});

  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: 325,
      height: 50,
      child: ElevatedButton(
        onPressed: onPress,
        child: Text(
          title,
          style: TextStyle(fontSize: 16),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) return color;
              return color; // Use the component's default.
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BuildText extends StatelessWidget {
  const BuildText(
      {super.key,
      required this.text,
      this.fontSize = 18,
      this.color = Colors.black,
      this.fontWeight = FontWeight.w500});
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: "Roboto"),
    );
  }
}

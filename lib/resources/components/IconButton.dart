import 'package:flutter/material.dart';

class BuildIconButton extends StatelessWidget {
  const BuildIconButton(
      {super.key,
      required this.icon,
      this.text = "",
      required this.callback,
      this.size = 30,
      this.color = Colors.black});
  final IconData icon;
  final String text;
  final double size;
  final VoidCallback callback;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Icon(
              icon,
              size: size,
              color: color,
            ),
            Text(text)
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BuildText extends StatelessWidget {
  const BuildText({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).primaryTextTheme.labelLarge);
  }
}

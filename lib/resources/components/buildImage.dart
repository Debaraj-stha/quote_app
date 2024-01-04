import 'package:flutter/material.dart';

class BuildImage extends StatelessWidget {
  const BuildImage(
      {super.key, required this.assetURL, this.width = 50, this.height = 50});
  final String assetURL;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      width: width,
      height: height,
      child: Image.asset(
        assetURL,
        fit: BoxFit.contain,
      ),
    );
  }
}

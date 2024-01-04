import 'package:flutter/material.dart';

class FavouriteQuote extends StatefulWidget {
  const FavouriteQuote({super.key});

  @override
  State<FavouriteQuote> createState() => _FavouriteQuoteState();
}

class _FavouriteQuoteState extends State<FavouriteQuote>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Favourite"),);
  }
}
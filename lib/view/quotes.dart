import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quote/view/singleQuote.dart';

import '../view_model/quoteViewModel.dart';

class Quotes extends StatefulWidget {
  const Quotes({super.key});

  @override
  State<Quotes> createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  @override
  Widget build(BuildContext context) {
    QuoteViewModel quoteModel = Get.find();
    int totalQuotes = quoteModel.quotes.length;
    return PageView.builder(
      itemCount: totalQuotes,
      itemBuilder: (context, index) {
      return SingleQuote(
        totalQuotes: totalQuotes,
        currentQuote: index,
        data: quoteModel.quotes[index],
        color: quoteModel.generateRandomColor(),
      );
    });
  }
}

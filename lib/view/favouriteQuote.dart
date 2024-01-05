import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view_model/homeViewMOdel.dart';
import '../resources/components/singleQuote.dart';

class FavouriteQuote extends StatefulWidget {
  const FavouriteQuote({super.key});

  @override
  State<FavouriteQuote> createState() => _FavouriteQuoteState();
}

class _FavouriteQuoteState extends State<FavouriteQuote>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final QuoteViewModel _quoteViewModel = Get.find();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _load();
  }

  _load() {
    _quoteViewModel.getFavouriteQotes();
    _quoteViewModel.update();
    _quoteViewModel.toggleLoading();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_quoteViewModel.isLoading.isTrue) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        if (_quoteViewModel.favouriteQuotes.isEmpty) {
          _quoteViewModel.update();
          return const Center(
            child: Text("No Favourite quotes"),
          );
        }
        return PageView.builder(
            itemCount: _quoteViewModel.favouriteQuotes.length,
            onPageChanged: (value) {
              _quoteViewModel.handlePageChange(value);
            },
            itemBuilder: (context, index) {
              return SingleQuote(
                totalQuotes: _quoteViewModel.favouriteQuotes.length,
                currentQuote: index + 1,
                data: _quoteViewModel.favouriteQuotes[index],
                color: _quoteViewModel.generateRandomColor(),
              );
            });
      }
    });
  }
}

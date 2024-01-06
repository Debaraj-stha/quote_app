import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quote/data/localeDatabase.dart';
import 'package:quote/reposiory/quotesRepo.dart';
import 'package:quote/resources/components/IconButton.dart';
import 'package:quote/resources/components/buildImage.dart';
import 'package:quote/view_model/homeViewMOdel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SingleQuote extends StatefulWidget {
  const SingleQuote(
      {super.key,
      required this.currentQuote,
      required this.totalQuotes,
      required this.data,
      this.color = const Color.fromARGB(255, 20, 132, 224)});
  final data;
  final Color color;
  final int currentQuote;
  final int totalQuotes;
  @override
  State<SingleQuote> createState() => _SingleQuoteState();
}

class _SingleQuoteState extends State<SingleQuote>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  late Animation<Color?> _colorTween;
  final QuoteViewModel _quoteViewModel = Get.find();
  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _colorTween = ColorTween(
      begin: Colors.black,
      end: Colors.red,
    ).animate(_controller);

    _animation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem(tween: Tween<double>(begin: 30, end: 50), weight: 50),
        TweenSequenceItem(tween: Tween<double>(begin: 50, end: 30), weight: 50),
      ],
    ).animate(_controller);
    _updateIsFavouriteFlag();
  }

  bool isAlreadySaved = false;
  void _updateIsFavouriteFlag() async {
    await _quoteViewModel
        .isAlreadyFavourite(widget.data.id.toString())
        .then((value) {
      setState(() {
        isAlreadySaved = value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final q = widget.data;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.currentQuote}  of  ${widget.totalQuotes}",
          style: const TextStyle(
              color: Colors.black, fontSize: 15, fontFamily: "Roboto"),
        ),
        elevation: 0,
        backgroundColor: widget.color,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 35),
        decoration: BoxDecoration(color: widget.color),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BuildImage(assetURL: "assets/quote_right.png"),
            const SizedBox(
              height: 20,
            ),
            Text(
              q.quote,
              style: const TextStyle(
                  fontSize: 20,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            const BuildImage(assetURL: "assets/quote_left.png"),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                const BuildImage(
                    assetURL: "assets/hand-writing-with-ballpen.png"),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    q.author,
                    style: const TextStyle(
                        fontSize: 25,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return BuildIconButton(
                      icon: _quoteViewModel.isFavourite.value
                          ? Icons.favorite
                          : Icons.favorite_border_rounded,
                      color: _quoteViewModel.isFavourite.value
                          ? Colors.red
                          : _colorTween.value!,
                      size: _animation.value,
                      text: AppLocalizations.of(context)!.favourite,
                      callback: () {
                        _quoteViewModel.addToFavouriteList(_controller, q);
                      },
                    );
                  },
                ),
                BuildIconButton(
                  icon: Icons.copy,
                  text: AppLocalizations.of(context)!.copy,
                  callback: () async {
                    await _quoteViewModel.copyToClipBoard(q.quote);
                  },
                ),
                BuildIconButton(
                  icon: Icons.share,
                  callback: () async {
                    await _quoteViewModel.shareQuote(q.quote);
                  },
                  text: AppLocalizations.of(context)!.share,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quote/reposiory/quotesRepo.dart';
import 'package:quote/resources/appURL.dart';
import 'package:quote/utils/utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/quoteModel.dart';
import 'package:http/http.dart' as http;

import '../reposiory/quoteData.dart';

class QuoteViewModel extends GetxController {
  final QuoteRepo _quoteRepo = QuoteRepo();

  final RxList _quotes = [].obs;
  List get quotes => _quotes.value;
  static String key = "i";
  RxInt index = RxInt(0);
  Future<void> copyToClipBoard(String text) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      Utils.showToastMessage("Quote copied to clipboard",
          bgColor: Colors.green, textColor: Colors.white);
    } catch (e) {
      Utils.showToastMessage("Exception occur while copying the text:$e");
    } //copy to clipboard
  }

  getQuote({int limit = 0, int skip = 0}) async {
    try {
      if (_quotes.isEmpty)
        for (var q in quoteData) {
          _quotes.add(Quote.fromJson(q));
        }
    } catch (e) {
      print(e);
    }

    // _quoteRepo.getQuoteAPI(limit, skip).then((value) {
    //   // print(value.toString());
    //   print("response: $value");
    // }).onError((error, stackTrace) {
    //   print(error.toString());
    //   Utils.showToastMessage(error.toString());
    // });
    update();
  }

  final RxBool isAlreadySaved = RxBool(false);

  Text() {
    List<Map<String, dynamic>> quotesList = List.generate(100, (index) {
      return {"index": index};
    });
    print(quotesList);
  }

  Color generateRandomColor() {
    final randomNumber = Random();

    return Color.fromARGB(randomNumber.nextInt(256), randomNumber.nextInt(256),
        randomNumber.nextInt(256), randomNumber.nextInt(256));
  }

  final RxBool _isFavourite = false.obs;
  RxBool get isFavourite => _isFavourite;
  void toggleLiked() {
    isFavourite.value = !isFavourite.value;
    print(isFavourite);
    update();
  }

  Future<bool> isAlreadyFavourite(String id) async {
    List<String> ids = await getSavedQuoteId();
    print("is already favourite:$id ");
    if (ids.contains(id)) {
      isFavourite.value = true;
      update();
      return true;
    } else {
      isFavourite.value = false;
      update();
      return false;
    }
  }

  void addToFavouriteList(AnimationController controller, Quote q) {
    if (isFavourite.isTrue) {
      controller.reverse();
      removeItemFromFavourite(q.id);
      isFavourite.value = false;
    } else {
      controller.forward();
      storeFavouriteQuoteId(q);
      isFavourite.value = true;
    }
    // toggleLiked();
    update();
  }

  void storeFavouriteQuoteId(Quote q) async {
    final sp = await SharedPreferences.getInstance();
    List<String> ids = await getSavedQuoteId();
    ids.add(q.id);
    sp.setStringList(key, ids);
    update();
  }

  Future<List<String>> getSavedQuoteId() async {
    final sp = await SharedPreferences.getInstance();
    List<String> ids = sp.getStringList(key) ?? [];
    return ids;
  }

  void removeItemFromFavourite(String id) async {
    final sp = await SharedPreferences.getInstance();
    List<String> x = await getSavedQuoteId();
    print("id ss$id");
    final remainingId = x.where((element) => element != id).toList();
    print("after removing$remainingId");
    sp.setStringList(key, remainingId);
    update();
  }

  void changeTab(int i) {
    index.value = i;
    update();
    print(i);
  }

  Future<void> shareQuote(String text) async {
    await Share.share(text, subject: "Share this quote");
  }
}

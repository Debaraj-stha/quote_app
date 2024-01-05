import 'package:flutter/foundation.dart';
import 'package:quote/data/appException.dart';
import 'package:quote/data/network/networkAPI.dart';
import 'package:quote/resources/appURL.dart';

import '../data/localeDatabase.dart';
import '../model/quoteModel.dart';

class QuoteRepo {
  final NetworkApi _networkApi = NetworkApi();
  Future<dynamic> getQuoteAPI(int limit, int skip) async {
    try {
      final data = await _networkApi.GETRequest(
          'https://api.quotable.io/quotes?limit=150');
      print("data");
      print(data.toString());
      return data;
    }
    //  on FetchDataException {
    //   rethrow;
    // } on BadRequestException {
    //   rethrow;
    // } on InternalServerError {
    //   rethrow;
    // } on UnAuthorizedRequest {
    //   rethrow;
    // }
    catch (e) {
      rethrow;
    }
  }

  Future<bool> removeFavouriteQotes(String id) async {
    try {
      final result = await DBController().deleteFavouriteQuote(id);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> savedQuoteToFavouriteQotes(Quote q) async {
    try {
      final result = await DBController().saveFavouriteQuote(q);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Quote>> getFavouriteQotes() async {
    try {
      List<Quote> value = await DBController().getFavouriteQotes();
      // print(value);
      return value;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return []; // Return an empty list in case of an error
    }
  }
}

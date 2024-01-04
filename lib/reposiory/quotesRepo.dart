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

  Future<bool> removeFavouriteQotes(int id) {
    try {
      DBController()
          .deleteFavouriteQuote(id)
          .then((value) => value)
          .onError((error, stackTrace) => false);
    } catch (e) {
      rethrow;
    }
    return Future.value(false);
  }

  Future<int> savedQuoteToFavouriteQotes(Quote q) async {
    try {
      await DBController().saveFavouriteQuote(q).then((value) {
        return value;
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print(error.toString());
        }
        return 0;
      });
    } catch (e) {
      rethrow;
    }
    return 0;
  }
}

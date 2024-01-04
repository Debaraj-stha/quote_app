import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:quote/data/appException.dart';
import 'package:quote/data/network/baseAPI.dart';
import 'package:quote/model/quoteModel.dart';
import 'package:http/http.dart' as http;

class NetworkApi extends BaseAPI {
  @override
  Future<dynamic> GETRequest(String url) async {
    dynamic responseData;
    try {
      Uri uri = Uri.parse(url);
      print("$uri");
      http.Response response = await http.get(uri);
      responseData = await returnJson(response);
      print("response data$responseData");
    } on SocketException {
      throw FetchDataException("No internet connection");
    } on TimeoutException {
      throw FetchDataException("Timeout for network connection");
    } catch (e) {
      print("catch");
      print(e.toString());
      throw FetchDataException("Error during API call: $e");
    }
    return responseData;
  }

  Future<dynamic> returnJson(http.Response response) async {
    final data = response.body;
    print("data$data");
    switch (response.statusCode) {
      case 200:
        dynamic decodedData = jsonDecode(data);
        if (decodedData is List) {
          return decodedData;
        } else {
          return [decodedData];
        }
      case 400:
        throw UnAuthorizedRequest(data);
      case 404:
        throw BadRequestException(data);
      case 500:
        throw InternalServerError(data);
      default:
        throw FetchDataException(data);
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:blocmvvm/data/app_excaptions.dart';
import 'package:http/http.dart' as http;
import 'package:blocmvvm/data/Network/base_api_service.dart';
import 'package:http/http.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJosn;

    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJosn = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJosn;
  }

  @override
  Future getPostApiResponse(String url, data) async {
    dynamic responseJson;
    try {
      Response response =
          await post(Uri.parse(url), body: data).timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(("No Internet Connection"),);
    }
  }
}

dynamic returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      dynamic responseJson = jsonDecode(response.body);
      return responseJson;
    case 404:
      throw BadRequestException(response.body.toString());
    default:
      throw  FetchDataException(
          "Error accured while communication with server with status code ${response.statusCode}");
  }
}

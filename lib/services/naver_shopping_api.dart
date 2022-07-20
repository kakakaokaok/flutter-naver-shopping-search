import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:naver_shopping_search/models/custom_error.dart';
import 'package:naver_shopping_search/models/store.dart';
import 'package:naver_shopping_search/services/http_error_handler.dart';

import '../models/search_query.dart';

class NaverShoppingApi {
  // final http.Client httpClient;
  // NaverShoppingApi({
  //   required this.httpClient,
  // });

  Future<List<Store>> getStoreList(SearchQuery searchQuery) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: dotenv.env['LAMBDA_URL'],
      path: '/search',
    );

    try {
      /// AWS Lambda를 사용할 때 connection 열어놓으면
      /// Lambda function에 걸리는 부하는? 어디서 확인해야하더라?
      final http.Response response =
          await http.post(uri, body: json.encode(searchQuery.toMap()), // String
              headers: {
            'Content-Type': 'application/json',
          });

      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }
      final responseBody =
          json.decode(utf8.decode(response.bodyBytes)); // List<dynamic>
      final storeList =
          responseBody.map<Store>((x) => Store.fromMap(x)).toList();
      return storeList; // List<Store>
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}

import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/custom_error.dart';
import '../models/search_query.dart';
import '../models/store.dart';
import 'http_error_handler.dart';

class NaverShoppingApi {
  Future<List<Store>> getStoreList(SearchQuery searchQuery) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: dotenv.env['LAMBDA_URL'],
      path: '/search',
    );

    try {
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

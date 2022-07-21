import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:naver_shopping_search/models/custom_error.dart';
import 'package:naver_shopping_search/models/search_query.dart';
import 'package:naver_shopping_search/services/naver_shopping_api.dart';

import '../models/store.dart';

// part 'result_state.dart';

class ResultProvider with ChangeNotifier {
  // ResultState _state = ResultState.initial();
  // ResultState get state => _state;

  final NaverShoppingApi naverShoppingApi;
  late SearchQuery searchQuery;
  late List<Store> storeList;
  ResultProvider({
    required this.naverShoppingApi,
  });

  Future<void> fetchResult() async {
    // _state = _state.copyWith(status: ResultStatus.loading);
    // notifyListeners();

    try {
      storeList = await naverShoppingApi.getStoreList(searchQuery);
      // _state = _state.copyWith(status: ResultStatus.loaded);
      notifyListeners();
    } on CustomError catch (e) {
      // _state = _state.copyWith(status: ResultStatus.error, error: e);
      // notifyListeners();
    }
  }
}

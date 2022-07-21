import 'package:flutter/material.dart';

import '../models/custom_error.dart';
import '../models/search_query.dart';
import '../models/store.dart';
import '../services/naver_shopping_api.dart';
import '../utils/logger.dart';

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
      // notifyListeners();
    } on CustomError catch (e) {
      // _state = _state.copyWith(status: ResultStatus.error, error: e);
      // notifyListeners();
      logger.d(e.errMsg);

      /// showDialog를 활용할 수 있다.
    }
  }
}

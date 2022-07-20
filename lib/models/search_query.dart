import 'dart:convert';

import 'package:flutter/material.dart';

class SearchQuery with ChangeNotifier {
  final int display;
  late String keywords;
  SearchQuery({
    this.display = 45,
    required this.keywords,
  });

  factory SearchQuery.initial() {
    return SearchQuery(keywords: '귀리');
  }

  @override
  String toString() => 'SearchQuery(display: $display, keywords: $keywords)';

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'display': display});
    result.addAll({'keywords': keywords});

    return result;
  }

  factory SearchQuery.fromMap(Map<String, dynamic> map) {
    return SearchQuery(
      display: map['display']?.toInt() ?? 0,
      keywords: map['keywords'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchQuery.fromJson(String source) =>
      SearchQuery.fromMap(json.decode(source));
}

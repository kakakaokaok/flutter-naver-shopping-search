import 'dart:convert';

import 'package:equatable/equatable.dart';

class Store extends Equatable {
  final String title;
  final String link;
  final String imageUrl;
  final String price;
  final String mallName;
  Store({
    required this.title,
    required this.link,
    required this.imageUrl,
    required this.price,
    required this.mallName,
  });

  factory Store.initial() {
    return Store(
      title: '',
      price: '',
      link: '',
      imageUrl: '',
      mallName: '',
    );
  }

  @override
  List<Object> get props {
    return [
      title,
      link,
      imageUrl,
      price,
      mallName,
    ];
  }

  @override
  String toString() {
    return 'Store(title: $title, link: $link, imageUrl: $imageUrl, price: $price, mallName: $mallName)';
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'link': link});
    result.addAll({'imageUrl': imageUrl});
    result.addAll({'price': price});
    result.addAll({'mallName': mallName});

    return result;
  }

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      title: map['title'] ?? '',
      link: map['link'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: map['price'] ?? '',
      mallName: map['mallName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Store.fromJson(String source) => Store.fromMap(json.decode(source));
}

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:naver_shopping_search/models/search_query.dart';
import 'package:naver_shopping_search/services/naver_shopping_api.dart';
import 'package:provider/provider.dart';
import 'pages/search_page.dart';
import 'package:http/http.dart' as http;

import 'providers/result_provider.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<NaverShoppingApi>(
          create: (context) => NaverShoppingApi(),
        ),
        ChangeNotifierProvider<ResultProvider>(
          create: (context) => ResultProvider(
            naverShoppingApi: context.read<NaverShoppingApi>(),
          ),
        )
      ],
      child: MaterialApp(
        title: '네이버쇼핑 검색',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: SearchPage(),
      ),
    );
  }
}

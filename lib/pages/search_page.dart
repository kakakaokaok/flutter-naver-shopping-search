import 'package:flutter/material.dart';
import 'package:naver_shopping_search/models/search_query.dart';
import 'package:naver_shopping_search/pages/result_page.dart';

import '../utils/logger.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();
  String? _keyword; // Provider
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  void _submit() {
    setState(() {
      autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form != null && form.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('검색을 시작합니다'),
      ));
      form.save();

      // 여기서 _keyword를 provider에 저장
      // Provider.of<SearchQuery>(context, listen: false).keyword = _keyword!;
      // var parsedJson;
      logger.d('${SearchQuery(keywords: _keyword!).toJson().runtimeType}');

      // logger.d('saved keyword: ${context.read<SearchQuery>().keyword}');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(),
        ),
      );
      form.reset();
      setState(() {
        autovalidateMode = AutovalidateMode.disabled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('네이버 쇼핑 검색'),
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 30.0),
        child: Center(
          child: Form(
            key: _formKey,
            autovalidateMode: autovalidateMode,
            child: Column(
              children: [
                const SizedBox(
                  height: 60.0,
                ),
                TextFormField(
                  autofocus: true,
                  style: TextStyle(fontSize: 18.0),
                  decoration: InputDecoration(
                    labelText: '검색어를 입력하세요',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? input) {
                    if (input == null || input.trim().length < 1) {
                      return '검색어를 입력하세요';
                    }
                    return null;
                  },
                  onSaved: (String? input) {
                    _keyword = input;
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text(
                    '검색',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

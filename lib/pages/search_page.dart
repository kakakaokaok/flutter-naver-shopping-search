import 'package:flutter/material.dart';
import 'package:naver_shopping_search/models/search_query.dart';
import 'package:naver_shopping_search/pages/result_page.dart';
import 'package:naver_shopping_search/providers/result_provider.dart';
import 'package:provider/provider.dart';

import '../utils/logger.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
// String? _keywords;
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

      // save form to the provider here

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
                    // _keywords = input;
                    context.read<ResultProvider>().searchQuery =
                        SearchQuery(display: 5, keywords: input!);
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

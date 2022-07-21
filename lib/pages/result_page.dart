import 'package:flutter/material.dart';
import 'package:naver_shopping_search/models/search_query.dart';
import 'package:naver_shopping_search/providers/result_provider.dart';
import 'package:provider/provider.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _HomePageState();
}

class _HomePageState extends State<ResultPage> {
  /// FutureBuilder 사용시 Stateless 가능?
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('검색 결과'),
      ),
      body: FutureBuilder(
          future: Future.delayed(Duration(seconds: 2), () async {
            await context.read<ResultProvider>().fetchResult();
            return context.read<ResultProvider>().storeList;
          }
              // 검색 함수 호출
              ),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              final _storeList = snapshot.data;
              return Center(
                child: ListView.builder(
                    itemBuilder: (context, int index) {
                      final _storeData = _storeList[index];
                      return ListTile(
                        title: Text(
                          '스토어명: ${_storeData.title}',
                          style: TextStyle(fontSize: 12.0),
                        ),
                      );
                    },
                    itemCount: _storeList.length),
              );
            } else if (snapshot.hasError) {
              // showDialog 활용, 또는 굳이 필요 없을듯?
              return const Text(
                '에러가 발생했습니다\n다시 검색해주세요',
                style: TextStyle(fontSize: 18.0),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

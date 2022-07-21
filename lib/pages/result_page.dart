import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../providers/result_provider.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('검색 결과'),
      ),
      body: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 2), () async {
            await context.read<ResultProvider>().fetchResult();
            return context.read<ResultProvider>().storeList;
          }
              // 검색 함수 호출
              ),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return Center(
                  child: const Text(
                    '검색 결과가 없습니다.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                );
              }
              final _storeList = snapshot.data;
              return Center(
                child: ListView.builder(
                  itemCount: _storeList.length,
                  itemBuilder: (context, int index) {
                    final _storeData = _storeList[index];
                    return ListTile(
                      title: Text(_storeData.title),
                      subtitle: Text(_storeData.mallName),
                      leading: SizedBox(
                        height: MediaQuery.of(context).size.height / 10,
                        width: MediaQuery.of(context).size.height / 10,
                        child: Image.network(_storeData.imageUrl),
                      ),
                      onTap: () async {
                        await launchUrlString(
                          _storeData.link,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      trailing: Text('${_storeData.price}원'),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: const Text(
                  '에러가 발생했습니다\n다시 검색해주세요',
                  style: TextStyle(fontSize: 18.0),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

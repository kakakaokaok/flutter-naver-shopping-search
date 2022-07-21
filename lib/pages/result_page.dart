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
            return await context.read<ResultProvider>().fetchResult();
          }
              // 검색 함수 호출
              ),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return const Center(
                  child: Text(
                    '검색 결과가 없습니다.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                );
              }
              final storeList = snapshot.data;
              return Center(
                child: ListView.builder(
                  itemCount: storeList.length,
                  itemBuilder: (context, int index) {
                    final storeData = storeList[index];
                    return ListTile(
                      title: Text(storeData.title),
                      subtitle: Text(storeData.mallName),
                      leading: SizedBox(
                        height: MediaQuery.of(context).size.height / 10,
                        width: MediaQuery.of(context).size.height / 10,
                        child: Image.network(storeData.imageUrl),
                      ),
                      onTap: () async {
                        await launchUrlString(
                          storeData.link,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      trailing: Text('${storeData.price}원'),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(
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

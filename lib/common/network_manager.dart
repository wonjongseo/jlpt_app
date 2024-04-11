import 'package:japanese_voca/data/grammar_datas.dart';
import 'package:japanese_voca/data/kangi_datas.dart';
import 'package:japanese_voca/data/word_datas.dart';

class NetWorkManager {
  // static Future<List<Word>> searchWrod(String word, String category) async {
  //   for (int i = 0; i < word.length; i++) {}
  //   final dio = Dio();

  //   String baseUrl = '';
  //   if (kReleaseMode) {
  //     baseUrl = 'https://wonjongseo-jonggack-company.koyeb.app/';
  //   } else {
  //     baseUrl = 'http://localhost:4000/';
  //   }
  //   // baseUrl = 'https://wonjongseo-jonggack-company.koyeb.app';
  //   String url = '${baseUrl}search';
  //   log('connect to $url');
  //   log('word: $word');

  //   var response = await dio.get(
  //     url,
  //     queryParameters: {
  //       'query': word,
  //     },
  //   );

  //   List<Word> result = [];
  //   List datas = await response.data['data'];

  //   for (int i = 0; i < datas.length; i++) {
  //     Word word = Word.fromMap(datas[i]);
  //     result.add(word);
  //   }

  //   return result;
  // }

  static List getDataToServer(String params) {
    switch (params) {
      case "N1-voca":
        return jsonN1Words;

      case "N2-voca":
        return jsonN2Words;

      case "N3-voca":
        return jsonN3Words;

      case "N4-voca":
        return jsonN4Words;

      case "N5-voca":
        return jsonN5Words;

      case "N1-kangi":
        return jsonN1Kangis;

      case "N2-kangi":
        return jsonN2Kangis;
      case "N3-kangi":
        return jsonN3Kangis;
      case "N4-kangi":
        return jsonN4Kangis;
      case "N5-kangi":
        return jsonN5Kangis;
      case "N6-kangi":
        return jsonN6Kangis;
      case "N1-grammar":
        return jsonN1Grammars;
      case "N2-grammar":
        return jsonN2Grammars;
      case "N3-grammar":
        return jsonN3Grammars;
    }
    return [];

    // final dio = Dio();

    // String baseUrl = '';
    // if (kReleaseMode) {
    //   baseUrl = 'https://wonjongseo-jonggack-company.koyeb.app';
    // } else {
    //   baseUrl = 'http://localhost:4000';
    // }
    // // baseUrl = 'https://wonjongseo-jonggack-company.koyeb.app';
    // log('connect to $baseUrl');
    // log('params: $params');
    // var response = await dio.get(
    //   // 'http://localhost:4000',
    //   baseUrl,
    //   queryParameters: {
    //     // 'data': 'N1-voca',
    //     'data': params,
    //   },
    // );
    // var json = await response.data['data'];

    // return json;
  }
}

//https://wonjongseo-jonggack-company.koyeb.app/?data=N1-voca
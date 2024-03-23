import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:japanese_voca/model/word.dart';

class NetWorkManager {
  static Future<List<Word>> searchWrod(String word, String category) async {
    for (int i = 0; i < word.length; i++) {}
    final dio = Dio();

    String baseUrl = '';
    if (kReleaseMode) {
      baseUrl = 'https://wonjongseo-jonggack-company.koyeb.app/';
    } else {
      baseUrl = 'http://localhost:4000';
    }
    // baseUrl = 'https://wonjongseo-jonggack-company.koyeb.app';
    String url = baseUrl + '/search';
    log('connect to $url');
    log('word: $word');

    var response = await dio.get(
      // 'http://localhost:4000',
      url,
      queryParameters: {
        // 'data': 'N1-voca',
        'query': word,
        'category': category
      },
    );
    print('response.data : ${response.data}');

    List<Word> result = [];
    List datas = await response.data['data'];

    for (int i = 0; i < datas.length; i++) {
      Word word = Word.fromMap(datas[i]);
      print('word : ${word}');
      result.add(word);
    }

    return result;
  }

  static Future getDataToServer(String params) async {
    final dio = Dio();

    String baseUrl = '';
    if (kReleaseMode) {
      baseUrl = 'https://wonjongseo-jonggack-company.koyeb.app';
    } else {
      baseUrl = 'http://localhost:4000';
    }
    // baseUrl = 'https://wonjongseo-jonggack-company.koyeb.app';
    log('connect to $baseUrl');
    log('params: $params');
    var response = await dio.get(
      // 'http://localhost:4000',
      baseUrl,
      queryParameters: {
        // 'data': 'N1-voca',
        'data': params,
      },
    );
    var json = await response.data['data'];

    return json;
  }
}

//https://wonjongseo-jonggack-company.koyeb.app/?data=N1-voca
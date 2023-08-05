import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class NetWorkManager {
  static Future getDataToServer(String params) async {
    final dio = Dio();

    String baseUrl = '';
    if (kReleaseMode) {
      baseUrl = 'https://wonjongseo-jonggack-company.koyeb.app';
    } else {
      baseUrl = 'http://localhost:4000';
    }

    log('connect to https://wonjongseo-jonggack-company.koyeb.app');
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
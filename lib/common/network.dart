import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:japanese_voca/common/network_manager.dart';

String papaoUri = 'https://openapi.naver.com/v1/papago/n2mt';
String dictionalUrl =
    'https://krdict.korean.go.kr/api/search?key=CF7771648C19129A0C22C4D44056BFAC&type_search=search&sort=popular&q=';

class NetWork {
  Future<String> getDictinoal({required word}) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      // 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
     'Access-Control-Allow-Origin': '*'
    };
    dictionalUrl = dictionalUrl + word;
    String result = '';
    try {
      http.Response res =
          await http.get(Uri.parse(dictionalUrl), headers: headers);
      print('res: ${res.body}');
      final resJson = json.decode(res.body);
      return '';
      
      // final response = await networkManager
      //     .request(RequestMethod.get, dictionalUrl, headers: headers);

      // if (response.data['message'] != null) {
      //   if (response.data['message']['result'] != null) {
      //     if (response.data['message']['result']['translatedText'] != null) {
      //       result = response.data['message']['result']['translatedText'];
      //     }
      //   }
      // }
      // return result;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  // static const String papagoBaseUrl =
  //   'https://openapi.naver.com/v1/papago/n2mt';
  //static const String papagoBaseUrl = 'http://localhost:3000/';
  static const String papagoBaseUrl =
      'https://won-translator.herokuapp.com/translate';

  NetworkManager networkManager = NetworkManager();
  Future<String> getWordMean(
      {required source, required target, required word}) async {
    // String source = 'en';
    // String target = 'ko';

    print('source: ${source}');
    print('target: ${target}');
    print('word: ${word}');

    String url = '$papagoBaseUrl?source=$source&target=$target&text=$word';
    String result = '';
    try {
      http.Response res = await http.get(Uri.parse(url));
      print('res: ${res.body}');
      final resJson = json.decode(res.body);

      if (resJson['message'] != null) {
        if (resJson['message']['result'] != null) {
          if (resJson['message']['result']['translatedText'] != null) {
            result = resJson['message']['result']['translatedText'];
          }
        }
      }
      print('resJson: ${resJson['message']}');

      return result;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}

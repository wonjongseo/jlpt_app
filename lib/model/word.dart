import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:japanese_voca/common/network_manager.dart';
import 'package:japanese_voca/model/example.dart';
import 'package:japanese_voca/model/hive_type.dart';
import 'package:japanese_voca/model/my_word.dart';

part 'word.g.dart';

@HiveType(typeId: WordTypeId)
class Word extends HiveObject {
  static final String boxKey = 'word';

  @HiveField(1)
  late String headTitle;
  @HiveField(2)
  late String word;
  @HiveField(3)
  late String yomikata;
  @HiveField(4)
  late String _mean;
  @HiveField(5)
  List<Example>? examples;
  @HiveField(6)
  late String? enMean;

  Word({
    // this.id,
    required this.word,
    required String mean,
    required this.yomikata,
    required this.headTitle,
    this.enMean,
    this.examples,
  }) : _mean = mean;

  String get mean {
    print(Get.deviceLocale);
    print(enMean);

    if (Get.locale == null) {
      print('1');
      return _mean;
    } else if (Get.locale!.countryCode == null) {
      print('2');
      return _mean;
    } else if (Get.locale!.countryCode!.contains("KR")) {
      print('3');
      return _mean;
    }
    print(enMean);
    return enMean ?? _mean;
  }

  @override
  String toString() {
    return "Word( word: $word, mean: $_mean, yomikata: $yomikata, headTitle: $headTitle, examples: $examples, enMean: $enMean)";
  }

  Word.fromMap(Map<String, dynamic> map) {
    word = map['word'] ?? '';
    yomikata = map['yomikata'] ?? '';
    _mean = map['mean'] ?? '';
    headTitle = map['headTitle'] ?? '';
    enMean = map['enMean'] ?? '';
    examples = map['examples'] == null
        ? []
        : List.generate(map['examples'].length,
            (index) => Example.fromMap(map['examples'][index]));
    // examples = map[''] List.generate(map['examples'].legth, (index) => null)
  }

  static Word myWordToWord(MyWord newWord) {
    return Word(
      word: newWord.getWord(),
      mean: newWord.mean,
      yomikata: newWord.yomikata ?? '',
      headTitle: '',
      examples: newWord.examples,
    );
  }

  static Future<List<List<Word>>> jsonToObject(String nLevel) async {
    List<List<Word>> words = [];

    var selectedJlptLevelJson = [];
    if (nLevel == '1') {
      selectedJlptLevelJson = NetWorkManager.getDataToServer('N1-voca');
    } else if (nLevel == '2') {
      selectedJlptLevelJson = NetWorkManager.getDataToServer('N2-voca');
    } else if (nLevel == '3') {
      selectedJlptLevelJson = NetWorkManager.getDataToServer('N3-voca');
    } else if (nLevel == '4') {
      selectedJlptLevelJson = NetWorkManager.getDataToServer('N4-voca');
    } else if (nLevel == '5') {
      selectedJlptLevelJson = NetWorkManager.getDataToServer('N5-voca');
    }

    for (int i = 0; i < selectedJlptLevelJson.length; i++) {
      List<Word> temp = [];
      for (int j = 0; j < selectedJlptLevelJson[i].length; j++) {
        Word word = Word.fromMap(selectedJlptLevelJson[i][j]);

        temp.add(word);
      }

      words.add(temp);
    }
    return words;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'headTitle': headTitle});
    result.addAll({'word': word});
    result.addAll({'yomikata': yomikata});
    result.addAll({'mean': _mean});
    result.addAll({'enMean': enMean});
    if (examples != null) {
      result.addAll({'examples': examples!.map((x) => x?.toMap()).toList()});
    }

    return result;
  }

  String toJson() => json.encode(toMap());

  factory Word.fromJson(String source) => Word.fromMap(json.decode(source));
}

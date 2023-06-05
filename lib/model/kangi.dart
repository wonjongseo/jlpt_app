// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:hive/hive.dart';
import 'package:japanese_voca/data/kangis_data.dart';
import 'package:japanese_voca/model/word.dart';

import 'hive_type.dart';

part 'kangi.g.dart';

@HiveType(typeId: KangiTypeId)
class Kangi extends HiveObject {
  static String boxKey = 'kangi_key';
  @HiveField(0)
  late String japan;
  @HiveField(1)
  late String korea;
  @HiveField(2)
  late String headTitle;
  @HiveField(3)
  late String undoc;
  @HiveField(4)
  late String hundoc;
  @HiveField(5)
  late List<Word> relatedVoca;

  Kangi(
      {required this.japan,
      required this.korea,
      required this.headTitle,
      required this.undoc,
      required this.hundoc,
      required this.relatedVoca});

  Kangi.fromMap(Map<String, dynamic> map) {
    japan = map['japan'] ?? '';
    korea = map['korea'] ?? '';
    headTitle = map['headTitle'] ?? '';
    undoc = map['undoc'] ?? '';
    hundoc = map['hundoc'] ?? '';
    relatedVoca = List.generate(map['relatedVoca'].length,
        (index) => Word.fromMap(map['relatedVoca'][index]));
  }

  @override
  String toString() {
    return "Kangi( Japan: $japan, korea: $korea, undoc: $undoc, headTitle: $headTitle, relatedVoca: $relatedVoca)";
  }

  static List<List<Kangi>> jsonToObject(String nLevel) {
    List<List<Kangi>> kangis = [];

    List<List<Map<String, dynamic>>> selectedKangiLevelJson = [];

    if (nLevel == '1') {
      selectedKangiLevelJson = jsonN1Kangis;
    } else if (nLevel == '2') {
      selectedKangiLevelJson = jsonN2Kangis;
    } else if (nLevel == '3') {
      selectedKangiLevelJson = jsonN3Kangis;
    } else if (nLevel == '4') {
      selectedKangiLevelJson = jsonN4Kangis;
    } else if (nLevel == '5') {
      selectedKangiLevelJson = jsonN5Kangis;
    } else if (nLevel == '6') {
      selectedKangiLevelJson = jsonN6Kangis;
    }

    for (int i = 0; i < selectedKangiLevelJson.length; i++) {
      List<Kangi> temp = [];
      for (int j = 0; j < selectedKangiLevelJson[i].length; j++) {
        temp.add(Kangi.fromMap(selectedKangiLevelJson[i][j]));
      }

      kangis.add(temp);
    }

    return kangis;
  }

// @ 으로 음독 , 훈독 구별
  Word kangiToWord() {
    return Word(
        word: japan,
        mean: korea,
        yomikata: '${undoc}@${hundoc}',
        headTitle: headTitle);
  }
}

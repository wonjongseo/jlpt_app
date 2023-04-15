// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:hive/hive.dart';
import 'package:japanese_voca/kangis_data.dart';
import 'package:japanese_voca/model/word.dart';

part 'kangi.g.dart';

@HiveType(typeId: 2)
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
  // @HiveField(6)
  // late int jlptLevel;

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

  static List<List<Kangi>> jsonToObject() {
    List<List<Kangi>> kangis = [];

    for (int i = 0; i < kangis_data.length; i++) {
      List<Kangi> temp = [];
      for (int j = 0; j < kangis_data[i].length; j++) {
        temp.add(Kangi.fromMap(kangis_data[i][j]));
      }

      kangis.add(temp);
    }

    return kangis;
  }

  Word kangiToWord() {
    return Word(
        word: japan,
        mean: korea,
        yomikata: '${undoc}/n${hundoc}',
        headTitle: headTitle);
  }
}

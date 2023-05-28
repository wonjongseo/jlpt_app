import 'package:hive/hive.dart';
import 'package:japanese_voca/data/jlpt_word_n2345_data.dart';

part 'word.g.dart';

@HiveType(typeId: 0)
class Word extends HiveObject {
  static final String boxKey = 'word';
  @HiveField(0)
  late int? id;
  @HiveField(1)
  late String headTitle;
  @HiveField(2)
  late String word;
  @HiveField(3)
  late String yomikata;
  @HiveField(4)
  late String mean;

  Word({
    this.id,
    required this.word,
    required this.mean,
    required this.yomikata,
    required this.headTitle,
  });

  @override
  String toString() {
    return "Word(id: $id, word: $word, mean: $mean, yomikata: $yomikata, headTitle: $headTitle)";
  }

  Word.fromMap(Map<String, dynamic> map) {
    id = map['id'] ?? -1;
    word = map['word'] ?? '';
    yomikata = map['yomikata'] ?? '';
    mean = map['mean'] ?? '';
    headTitle = map['headTitle'] ?? '';
  }

  static List<List<Word>> jsonToObject(String nLevel) {
    List<List<Word>> words = [];

    List<List<Map<String, dynamic>>> selectedJlptLevelJson = [];
    if (nLevel == '1') {
      selectedJlptLevelJson = jsonN1Words;
    } else if (nLevel == '2') {
      selectedJlptLevelJson = jsonN2Words;
    } else if (nLevel == '3') {
      selectedJlptLevelJson = jsonN3Words;
    } else if (nLevel == '4') {
      selectedJlptLevelJson = jsonN4Words;
    } else if (nLevel == '5') {
      selectedJlptLevelJson = jsonN5Words;
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
}

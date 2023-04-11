import 'package:hive/hive.dart';
import 'package:japanese_voca/jlpt_word_data.dart';
import 'package:japanese_voca/model/grammar.dart';

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
  @HiveField(5)
  bool? isKnown = false;
  @HiveField(6)
  bool? isLike = false;

  Word({
    this.id,
    required this.word,
    required this.mean,
    required this.yomikata,
    required this.headTitle,
    this.isKnown,
    this.isLike,
  });

  @override
  String toString() {
    return "Word(id: $id, word: $word, mean: $mean, yomikata: $yomikata, headTitle: $headTitle, isKnown: $isKnown, isLike: $isLike)";
  }

  Word.fromMap(Map<String, dynamic> map) {
    id = map['id'] ?? -1;
    word = map['word'] ?? '';
    yomikata = map['yomikata'] ?? '';
    mean = map['mean'] ?? '';
    headTitle = map['headTitle'] ?? '';
    isKnown = map['isKnown'] ?? false;
    isLike = map['isLike'] ?? false;
  }

  static List<List<Word>> jsonToObject(String nLevel) {
    print('jsonToObjectJLPT');
    List<List<Word>> words = [];

    if (nLevel == '1') {
      for (int i = 0; i < jsonWords.length; i++) {
        List<Word> temp = [];
        for (int j = 0; j < jsonWords[i].length; j++) {
          temp.add(Word.fromMap(jsonWords[i][j]));
        }

        words.add(temp);
      }
    }

    return words;
  }
}

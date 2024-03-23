import 'package:hive/hive.dart';
import 'package:japanese_voca/common/network_manager.dart';
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
  late String mean;

  Word({
    // this.id,
    required this.word,
    required this.mean,
    required this.yomikata,
    required this.headTitle,
  });

  @override
  String toString() {
    return "Word( word: $word, mean: $mean, yomikata: $yomikata, headTitle: $headTitle)";
  }

  Word.fromMap(Map<String, dynamic> map) {
    word = map['word'] ?? '';
    yomikata = map['yomikata'] ?? '';
    mean = map['mean'] ?? '';
    headTitle = map['headTitle'] ?? '';
  }

  static Word myWordToWord(MyWord newWord) {
    return Word(
      word: newWord.word,
      mean: newWord.mean,
      yomikata: newWord.yomikata ?? '',
      headTitle: '',
    );
  }

  static Future<List<List<Word>>> jsonToObject(String nLevel) async {
    List<List<Word>> words = [];

    var selectedJlptLevelJson = [];
    if (nLevel == '1') {
      selectedJlptLevelJson = await NetWorkManager.getDataToServer('N1-voca');
    } else if (nLevel == '2') {
      selectedJlptLevelJson = await NetWorkManager.getDataToServer('N2-voca');
    } else if (nLevel == '3') {
      selectedJlptLevelJson = await NetWorkManager.getDataToServer('N3-voca');
    } else if (nLevel == '4') {
      selectedJlptLevelJson = await NetWorkManager.getDataToServer('N4-voca');
    } else if (nLevel == '5') {
      selectedJlptLevelJson = await NetWorkManager.getDataToServer('N5-voca');
    }

    // if (nLevel == '1') {
    //   selectedJlptLevelJson = jsonN1Words;
    // } else if (nLevel == '2') {
    //   selectedJlptLevelJson = jsonN2Words;
    // } else if (nLevel == '3') {
    //   selectedJlptLevelJson = jsonN3Words;
    // } else if (nLevel == '4') {
    //   selectedJlptLevelJson = jsonN4Words;
    // } else if (nLevel == '5') {
    //   selectedJlptLevelJson = jsonN5Words;
    // }

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

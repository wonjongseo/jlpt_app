import 'package:hive/hive.dart';
import 'package:japanese_voca/model/hive_type.dart';

part 'user.g.dart';

@HiveType(typeId: UserTypeId)
class User extends HiveObject {
  User({
    required this.jlptWordScroes,
    required this.grammarScores,
    required this.kangiScores,
    required this.currentJlptWordScroes,
    required this.currentGrammarScores,
    required this.currentKangiScores,
  });

  static String boxKey = 'user_key';

  // @HiveField(7, defaultValue: 0)
  // int countMyWords = 0;

  @HiveField(5)
  List<int> currentGrammarScores = [];

  @HiveField(4)
  // N5 현재 진형량의 인덱스는 4
  List<int> currentJlptWordScroes = [];

  @HiveField(6)
  List<int> currentKangiScores = [];

  @HiveField(2)
  List<int> grammarScores = [];

  // @HiveField(0)
  // int heartCount;

  // bool isFake = false;
  @HiveField(100, defaultValue: false)
  bool isPremieum = false;
  // bool isPremieum = false;

  @HiveField(1)
  List<int> jlptWordScroes = [];

  @HiveField(3)
  List<int> kangiScores = [];

  @HiveField(8, defaultValue: 0)
  int yokumatigaeruMyWords = 0;

  @HiveField(99, defaultValue: 0)
  int manualSavedMyWords = 0;

  @override
  String toString() {
    return 'User(jlptWordScroes: $jlptWordScroes, grammarScores: $grammarScores, kangiScores: $kangiScores\ncurrentJlptWordScroes: $currentJlptWordScroes, currentGrammarScores: $currentGrammarScores, currentKangiScores: $currentKangiScores)';
  }
}

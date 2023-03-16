import 'package:hive/hive.dart';

part 'word.g.dart';

@HiveType(typeId: 0)
class Word {
  static final String boxKey = 'word';
  @HiveField(0)
  late String word;
  @HiveField(1)
  late String yomikata;
  @HiveField(2)
  late String mean;
  @HiveField(3)
  bool? isKnown = false;
  @HiveField(4)
  bool? isLike = false;
  @HiveField(5)
  bool? isMine = false;

  Word(
      {required this.word,
      required this.mean,
      required this.yomikata,
      this.isKnown,
      this.isLike,
      this.isMine});

  @override
  String toString() {
    return "Word(word: $word, mean: $mean, yomikata: $yomikata, isKnown: $isKnown, isLike: $isLike, isMine: $isMine)";
  }

  Word.fromMap(Map<String, dynamic> map) {
    word = map['word'] ?? '';
    yomikata = map['yomikata'] ?? '';
    mean = map['mean'] ?? '';
    isKnown = map['isKnown'] ?? false;
    isLike = map['isLike'] ?? false;
    isMine = map['isMine'] ?? false;
  }
}

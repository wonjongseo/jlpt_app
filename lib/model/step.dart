import 'package:hive/hive.dart';
import 'package:japanese_voca/model/word.dart';
part 'step.g.dart';

@HiveType(typeId: 2)
class StepHive extends HiveObject {
  static final String boxKey = 'step';
  static final String boxListKey = 'step-list';

  @HiveField(0)
  late String id;

  @HiveField(1)
  List<Word> words = [];

  @HiveField(2)
  int scores = 0;

  @HiveField(3)
  List<Word>? unKnownWords = [];

  @HiveField(4)
  bool isClear = false;

  @HiveField(5)
  late int buttonCount = 0;

  StepHive({required this.id, required this.words, required this.buttonCount});

  @override
  String toString() {
    return "Step(id: $id, words: $words, scores: $scores, buttonCount: $buttonCount, unKnownWords: ${unKnownWords ?? []}, isClear: $isClear)";
  }

  StepHive.fromMap(Map<String, dynamic> map) {
    id = map['id'] ?? '';
    words = List<Word>.of(map['words']) ?? [];
    unKnownWords = List<Word>.of(map['unKnownWords']) ?? [];
    scores = map['scores'] ?? 0;
    isClear = map['isClear'] ?? false;
  }
}

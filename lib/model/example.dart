import 'package:hive/hive.dart';
import 'package:japanese_voca/model/hive_type.dart';
part 'example.g.dart';

@HiveType(typeId: ExampleTypeId)
class Example {
  static String boxKey = 'example_key';
  @HiveField(0)
  late String word;
  @HiveField(1)
  late String mean;
  @HiveField(2)
  late String? answer;
  @HiveField(3)
  late String? yomikata;

  Example({required this.word, required this.mean, this.answer, this.yomikata});

  Example.fromMap(Map<String, dynamic> map) {
    word = map['word'] ?? '';
    mean = map['mean'] ?? '';
    answer = map['answer'] ?? '';
    yomikata = map['yomikata'] ?? '';
  }

  @override
  String toString() {
    return 'Example(word: "$word", mean: "$mean", yomikata: "$yomikata", answer: "$answer")';
  }
}

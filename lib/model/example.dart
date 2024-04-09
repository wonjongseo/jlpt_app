import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'word': word});
    result.addAll({'mean': mean});
    if (answer != null) {
      result.addAll({'answer': answer});
    }
    if (yomikata != null) {
      result.addAll({'yomikata': yomikata});
    }

    return result;
  }

  String toJson() => json.encode(toMap());

  factory Example.fromJson(String source) =>
      Example.fromMap(json.decode(source));
}

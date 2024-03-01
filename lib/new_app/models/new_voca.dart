import 'dart:convert';

import 'package:japanese_voca/new_app/models/new_voca_example.dart';

class NewVoca {
  String word; // 私的　Or 私
  String mean; // 사적 Or 사사로울 사
  List<NewVocaExample> examples;

  NewVoca({
    required this.word,
    required this.mean,
    required this.examples,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'word': word});
    result.addAll({'mean': mean});
    result.addAll({'examples': examples.map((x) => x.toMap()).toList()});

    return result;
  }

  factory NewVoca.fromMap(Map<String, dynamic> map) {
    return NewVoca(
      word: map['word'] ?? '',
      mean: map['mean'] ?? '',
      examples: List<NewVocaExample>.from(
          map['examples']?.map((x) => NewVocaExample.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory NewVoca.fromJson(String source) =>
      NewVoca.fromMap(json.decode(source));
}

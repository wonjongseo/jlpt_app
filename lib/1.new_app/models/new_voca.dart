import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:japanese_voca/1.new_app/models/new_voca_example.dart';
import 'package:japanese_voca/model/hive_type.dart';

part 'new_voca.g.dart';

@HiveType(typeId: NewVocaId)
class NewVoca {
  static String boxKey = 'new_voca_key';

  @HiveField(0)
  String word; // 私的　Or 私
  @HiveField(1)
  String mean; // 사적 Or 사사로울 사
  @HiveField(2)
  List<NewVocaExample> examples;
  @HiveField(3)
  bool isSaved = false;
  NewVoca({
    required this.word,
    required this.mean,
    required this.examples,
    this.isSaved = false,
  });

  NewVoca copyWith({
    String? word,
    String? mean,
    List<NewVocaExample>? examples,
    bool? isSaved,
  }) {
    return NewVoca(
      word: word ?? this.word,
      mean: mean ?? this.mean,
      examples: examples ?? this.examples,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'word': word});
    result.addAll({'mean': mean});
    result.addAll({'examples': examples.map((x) => x.toMap()).toList()});
    result.addAll({'isSaved': isSaved});

    return result;
  }

  factory NewVoca.fromMap(Map<String, dynamic> map) {
    return NewVoca(
      word: map['word'] ?? '',
      mean: map['mean'] ?? '',
      examples: List<NewVocaExample>.from(
          map['examples']?.map((x) => NewVocaExample.fromMap(x))),
      isSaved: map['isSaved'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewVoca.fromJson(String source) =>
      NewVoca.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NewVoca(word: $word, mean: $mean, examples: $examples, isSaved: $isSaved)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewVoca &&
        other.word == word &&
        other.mean == mean &&
        listEquals(other.examples, examples) &&
        other.isSaved == isSaved;
  }

  @override
  int get hashCode {
    return word.hashCode ^ mean.hashCode ^ examples.hashCode ^ isSaved.hashCode;
  }
}

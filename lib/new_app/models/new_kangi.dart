import 'dart:convert';

import 'package:japanese_voca/new_app/models/new_voca.dart';
import 'package:japanese_voca/new_app/models/new_voca_example.dart';

class NewKangi extends NewVoca {
  String undoc;
  String hundoc;
  NewKangi({
    required this.undoc,
    required this.hundoc,
    required super.word,
    required super.mean,
    required super.examples,
  });

  NewKangi copyWith({
    String? undoc,
    String? hundoc,
  }) {
    return NewKangi(
      undoc: undoc ?? this.undoc,
      hundoc: hundoc ?? this.hundoc,
      word: word ?? super.word,
      mean: mean ?? super.mean,
      examples: examples ?? super.examples,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'undoc': undoc});
    result.addAll({'hundoc': hundoc});
    result.addAll({'word': word});
    result.addAll({'mean': mean});
    result.addAll({'examples': examples.map((x) => x.toMap()).toList()});

    return result;
  }

  factory NewKangi.fromMap(Map<String, dynamic> map) {
    return NewKangi(
      undoc: map['undoc'] ?? '',
      hundoc: map['hundoc'] ?? '',
      word: map['word'] ?? '',
      mean: map['mean'] ?? '',
      examples: List<NewVocaExample>.from(
          map['examples']?.map((x) => NewVocaExample.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory NewKangi.fromJson(String source) =>
      NewKangi.fromMap(json.decode(source));

  @override
  String toString() => 'NewKangi(undoc: $undoc, hundoc: $hundoc)';
}

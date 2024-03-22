import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
import 'package:japanese_voca/model/hive_type.dart';
part 'new_voca_example.g.dart';

@HiveType(typeId: NewVocaExampleId)
class NewVocaExample {
  static String boxKey = 'new_voca_example_key';
  @HiveField(0)
  String example;
  @HiveField(1)
  String yomikata;
  @HiveField(2)
  String mean;
  NewVocaExample({
    required this.example,
    required this.yomikata,
    required this.mean,
  });

  NewVocaExample copyWith({
    String? example,
    String? yomikata,
    String? mean,
  }) {
    return NewVocaExample(
      example: example ?? this.example,
      yomikata: yomikata ?? this.yomikata,
      mean: mean ?? this.mean,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'example': example});
    result.addAll({'yomikata': yomikata});
    result.addAll({'mean': mean});

    return result;
  }

  factory NewVocaExample.fromMap(Map<String, dynamic> map) {
    return NewVocaExample(
      example: map['example'] ?? '',
      yomikata: map['yomikata'] ?? '',
      mean: map['mean'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NewVocaExample.fromJson(String source) =>
      NewVocaExample.fromMap(json.decode(source));

  @override
  String toString() =>
      'NewVocaExample(example: $example, yomikata: $yomikata, mean: $mean)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewVocaExample &&
        other.example == example &&
        other.yomikata == yomikata &&
        other.mean == mean;
  }

  @override
  int get hashCode => example.hashCode ^ yomikata.hashCode ^ mean.hashCode;
}

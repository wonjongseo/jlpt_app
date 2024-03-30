// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WordAdapter extends TypeAdapter<Word> {
  @override
  final int typeId = 0;

  @override
  Word read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Word(
      word: fields[2] as String,
      mean: fields[4] as String,
      yomikata: fields[3] as String,
      headTitle: fields[1] as String,
      examples: (fields[5] as List?)?.cast<Example>(),
    );
  }

  @override
  void write(BinaryWriter writer, Word obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.headTitle)
      ..writeByte(2)
      ..write(obj.word)
      ..writeByte(3)
      ..write(obj.yomikata)
      ..writeByte(4)
      ..write(obj.mean)
      ..writeByte(5)
      ..write(obj.examples);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

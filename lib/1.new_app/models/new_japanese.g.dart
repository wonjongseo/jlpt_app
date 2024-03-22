// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_japanese.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewJapaneseAdapter extends TypeAdapter<NewJapanese> {
  @override
  final int typeId = 23;

  @override
  NewJapanese read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewJapanese(
      yomikata: fields[4] as String,
      word: fields[0] as String,
      mean: fields[1] as String,
      examples: (fields[2] as List).cast<NewVocaExample>(),
      isSaved: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, NewJapanese obj) {
    writer
      ..writeByte(5)
      ..writeByte(4)
      ..write(obj.yomikata)
      ..writeByte(0)
      ..write(obj.word)
      ..writeByte(1)
      ..write(obj.mean)
      ..writeByte(2)
      ..write(obj.examples)
      ..writeByte(3)
      ..write(obj.isSaved);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewJapaneseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

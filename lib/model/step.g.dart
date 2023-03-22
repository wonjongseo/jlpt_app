// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StepAdapter extends TypeAdapter<StepHive> {
  @override
  final int typeId = 2;

  @override
  StepHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StepHive(
      id: fields[0] as String,
      words: (fields[1] as List).cast<Word>(),
      buttonCount: fields[5] as int,
    )
      ..scores = fields[2] as int
      ..unKnownWords = (fields[3] as List?)?.cast<Word>()
      ..isClear = fields[4] as bool;
  }

  @override
  void write(BinaryWriter writer, StepHive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.words)
      ..writeByte(2)
      ..write(obj.scores)
      ..writeByte(3)
      ..write(obj.unKnownWords)
      ..writeByte(4)
      ..write(obj.isClear)
      ..writeByte(5)
      ..write(obj.buttonCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StepAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

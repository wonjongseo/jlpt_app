// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kangi_step.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KangiStepAdapter extends TypeAdapter<KangiStep> {
  @override
  final int typeId = 14;

  @override
  KangiStep read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KangiStep(
      headTitle: fields[0] as String,
      step: fields[1] as int,
      kangis: (fields[2] as List).cast<Kangi>(),
      scores: fields[4] as int,
    )..unKnownKangis = (fields[3] as List).cast<Kangi>();
  }

  @override
  void write(BinaryWriter writer, KangiStep obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.headTitle)
      ..writeByte(1)
      ..write(obj.step)
      ..writeByte(2)
      ..write(obj.kangis)
      ..writeByte(3)
      ..write(obj.unKnownKangis)
      ..writeByte(4)
      ..write(obj.scores);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KangiStepAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

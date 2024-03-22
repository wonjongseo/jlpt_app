// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_voca_example.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewVocaExampleAdapter extends TypeAdapter<NewVocaExample> {
  @override
  final int typeId = 21;

  @override
  NewVocaExample read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewVocaExample(
      example: fields[0] as String,
      yomikata: fields[1] as String,
      mean: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NewVocaExample obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.example)
      ..writeByte(1)
      ..write(obj.yomikata)
      ..writeByte(2)
      ..write(obj.mean);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewVocaExampleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_kangi.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewKangiAdapter extends TypeAdapter<NewKangi> {
  @override
  final int typeId = 22;

  @override
  NewKangi read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewKangi(
      undoc: fields[4] as String,
      hundoc: fields[5] as String,
      word: fields[0] as String,
      mean: fields[1] as String,
      examples: (fields[2] as List).cast<NewVocaExample>(),
      isSaved: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, NewKangi obj) {
    writer
      ..writeByte(6)
      ..writeByte(4)
      ..write(obj.undoc)
      ..writeByte(5)
      ..write(obj.hundoc)
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
      other is NewKangiAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

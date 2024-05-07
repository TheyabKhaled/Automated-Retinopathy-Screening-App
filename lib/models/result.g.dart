// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResultAdapter extends TypeAdapter<Result> {
  @override
  final int typeId = 2;

  @override
  Result read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Result(
      fields[1] as double?,
      fields[0] as int?,
      fields[2] as String?,
    )
      ..date = fields[3] as String?
      ..leftEyeImg = fields[4] as Uint8List?
      ..rightEyeImg = fields[5] as Uint8List?
      ..uid = fields[6] as String?;
  }

  @override
  void write(BinaryWriter writer, Result obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.confidence)
      ..writeByte(2)
      ..write(obj.label)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.leftEyeImg)
      ..writeByte(5)
      ..write(obj.rightEyeImg)
      ..writeByte(6)
      ..write(obj.uid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

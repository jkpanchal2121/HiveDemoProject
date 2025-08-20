// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'damage_cost_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DamageCostAdapter extends TypeAdapter<DamageCost> {
  @override
  final int typeId = 1;

  @override
  DamageCost read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DamageCost(
      part: fields[0] as String,
      costMinus10CM: fields[1] as String,
      costPlus10CM: fields[2] as String,
      administrativeFee: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DamageCost obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.part)
      ..writeByte(1)
      ..write(obj.costMinus10CM)
      ..writeByte(2)
      ..write(obj.costPlus10CM)
      ..writeByte(3)
      ..write(obj.administrativeFee);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DamageCostAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

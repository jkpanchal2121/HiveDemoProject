// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_cost_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdditionalCostAdapter extends TypeAdapter<AdditionalCost> {
  @override
  final int typeId = 0;

  @override
  AdditionalCost read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdditionalCost(
      issue: fields[0] as String,
      ownerFixedPrice: fields[1] as String,
      administrativeFee: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AdditionalCost obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.issue)
      ..writeByte(1)
      ..write(obj.ownerFixedPrice)
      ..writeByte(2)
      ..write(obj.administrativeFee);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdditionalCostAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

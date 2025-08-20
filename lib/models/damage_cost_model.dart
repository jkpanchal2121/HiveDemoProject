import 'package:hive/hive.dart';

part 'damage_cost_model.g.dart';

@HiveType(typeId: 1)
class DamageCost extends HiveObject {
  @HiveField(0)
  String part;

  @HiveField(1)
  String costMinus10CM;

  @HiveField(2)
  String costPlus10CM;

  @HiveField(3)
  String administrativeFee;

  DamageCost({
    required this.part,
    required this.costMinus10CM,
    required this.costPlus10CM,
    required this.administrativeFee,
  });
}

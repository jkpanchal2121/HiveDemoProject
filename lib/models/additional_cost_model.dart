import 'package:hive/hive.dart';
part 'additional_cost_model.g.dart';


@HiveType(typeId: 0)
class AdditionalCost extends HiveObject {
  @HiveField(0)
  String issue;

  @HiveField(1)
  String ownerFixedPrice;

  @HiveField(2)
  String administrativeFee;

  AdditionalCost({
    required this.issue,
    required this.ownerFixedPrice,
    required this.administrativeFee,
  });
}

import 'package:hive/hive.dart';

import '../models/additional_cost_model.dart';
import '../models/damage_cost_model.dart';

class ProductCostRepository {
  static const String _additionalBox = "additionalcost";
  static const String _damageBox = "damagecost";

  /// Open AdditionalCost Box
  Future<Box<AdditionalCost>> _openAdditionalBox() async {
    return await Hive.openBox<AdditionalCost>(_additionalBox);
  }

  /// Open DamageCost Box
  Future<Box<DamageCost>> _openDamageBox() async {
    return await Hive.openBox<DamageCost>(_damageBox);
  }

  //-------------------- AdditionalCost Methods --------------------//

  Future<void> addAdditionalCost(AdditionalCost cost) async {
    final box = await _openAdditionalBox();
    await box.add(cost);
  }

  Future<List<AdditionalCost>> getAllAdditionalCosts() async {
    final box = await _openAdditionalBox();
    return box.values.toList();
  }

  //-------------------- DamageCost Methods --------------------//

  Future<void> addDamageCost(DamageCost cost) async {
    final box = await _openDamageBox();
    await box.add(cost);
  }

  Future<List<DamageCost>> getAllDamageCosts() async {
    final box = await _openDamageBox();
    return box.values.toList();
  }
}

part of 'product_cost_bloc.dart';

@immutable
abstract class ProductCostEvent {}

class ProductInitialEvent extends ProductCostEvent {}

/// get all additional cost
class GetAllAdditionalEvent extends ProductCostEvent {}

/// get all damage cost
class GetAllDamageEvent extends ProductCostEvent {}

/// add additional cost
class AddAdditionalEvent extends ProductCostEvent {
  final AdditionalCost additionalCost;

  AddAdditionalEvent(this.additionalCost);
}

/// add damage cost
class AddDamageEvent extends ProductCostEvent {
  final DamageCost damageCost;
  AddDamageEvent(this.damageCost);
}

part of 'product_cost_bloc.dart';

@immutable
final class ProductCostInitial extends ProductCostState {}

@immutable
class ProductCostState extends Equatable {
  final RequestStatus getAllAdditionalCostStatus;
  final RequestStatus getAllDamageCostStatus;
  final RequestStatus addDamageCostStatus;
  final RequestStatus addAdditionalCostStatus;
  final List<AdditionalCost>? additionalCostData;
  final List<DamageCost>? damageCostData;

  final int? statusCode;
  final String? errorMessage;

  const ProductCostState({
    this.getAllAdditionalCostStatus = RequestStatus.initial,
    this.getAllDamageCostStatus = RequestStatus.initial,
    this.addAdditionalCostStatus = RequestStatus.initial,
    this.addDamageCostStatus = RequestStatus.initial,
    this.additionalCostData,
    this.damageCostData,
    this.statusCode,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
    getAllAdditionalCostStatus,
    getAllDamageCostStatus,
    additionalCostData,
    damageCostData,
    statusCode,
    errorMessage,
  ];

  ProductCostState copyWith({
    RequestStatus? getAllAdditionalCostStatus,
    RequestStatus? getAllDamageCostStatus,
    RequestStatus? addDamageCostStatus,
     RequestStatus? addAdditionalCostStatus,
    List<AdditionalCost>? additionalCostData,
    List<DamageCost>? damageCostData,
    int? statusCode,
    String? errorMessage,
  }) {
    return ProductCostState(
       addAdditionalCostStatus:   addAdditionalCostStatus ?? this.addAdditionalCostStatus,
      addDamageCostStatus:  addDamageCostStatus ?? this.addDamageCostStatus,
      additionalCostData: additionalCostData ?? this.additionalCostData,
      damageCostData: damageCostData ?? this.damageCostData,
      getAllAdditionalCostStatus:
          getAllAdditionalCostStatus ?? this.getAllAdditionalCostStatus,
      getAllDamageCostStatus:
          getAllDamageCostStatus ?? this.getAllDamageCostStatus,
      statusCode: statusCode,
      errorMessage: errorMessage,
    );
  }
}

enum RequestStatus { initial, loading, success, failure }

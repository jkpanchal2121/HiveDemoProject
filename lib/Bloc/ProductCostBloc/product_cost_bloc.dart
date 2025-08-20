import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';

import '../../Repo/product_cost_repo.dart';
import '../../models/additional_cost_model.dart';
import '../../models/damage_cost_model.dart';

part 'product_cost_event.dart';
part 'product_cost_state.dart';

class ProductCostBloc extends Bloc<ProductCostEvent, ProductCostState> {
  final ProductCostRepository repository;

  ProductCostBloc(this.repository) : super(ProductCostInitial()) {
    on<ProductCostEvent>((event, emit) {});
    on<AddAdditionalEvent>(_addAdditionalCost);
    on<AddDamageEvent>(_addADamageCost);
    on<GetAllAdditionalEvent>(_getAdditionalCost);
    on<GetAllDamageEvent>(_getADamageCost);
  }

  /// add additional cost
  Future<void> _addAdditionalCost(
    AddAdditionalEvent event,
    Emitter<ProductCostState> emit,
  ) async {
    emit(state.copyWith(addAdditionalCostStatus: RequestStatus.loading));
    try {
      await repository.addAdditionalCost(event.additionalCost);
      final costs = await repository.getAllAdditionalCosts();
      emit(
        state.copyWith(
          addAdditionalCostStatus: RequestStatus.success,
          getAllAdditionalCostStatus: RequestStatus.success,
          additionalCostData: costs,
        ),
      );
    } catch (e) {
      emit(state.copyWith(addAdditionalCostStatus: RequestStatus.failure));
      _handleError(e, emit);
    }
  }

  /// get all additional cost
  Future<void> _getAdditionalCost(
    GetAllAdditionalEvent event,
    Emitter<ProductCostState> emit,
  ) async {
    emit(state.copyWith(getAllAdditionalCostStatus: RequestStatus.loading));
    try {
      final costs = await repository.getAllAdditionalCosts();
      emit(
        state.copyWith(
          getAllAdditionalCostStatus: RequestStatus.success,
          additionalCostData: costs,
        ),
      );
    } catch (e) {
      emit(state.copyWith(getAllAdditionalCostStatus: RequestStatus.failure));
      _handleError(e, emit);
    }
  }

  /// add damage cost
  Future<void> _addADamageCost(
    AddDamageEvent event,
    Emitter<ProductCostState> emit,
  ) async {
    emit(state.copyWith(addDamageCostStatus: RequestStatus.loading));
    try {
      await repository.addDamageCost(event.damageCost);
      final costs = await repository.getAllDamageCosts();
      emit(
        state.copyWith(
          addDamageCostStatus: RequestStatus.success,
          getAllDamageCostStatus: RequestStatus.success,
          damageCostData: costs,
        ),
      );
    } catch (e) {
      emit(state.copyWith(addDamageCostStatus: RequestStatus.failure));
      _handleError(e, emit);
    }
  }

  /// get all damage cost
  Future<void> _getADamageCost(
    GetAllDamageEvent event,
    Emitter<ProductCostState> emit,
  ) async {
    emit(state.copyWith(getAllDamageCostStatus: RequestStatus.loading));
    try {
      final costs = await repository.getAllDamageCosts();
      emit(
        state.copyWith(
          getAllDamageCostStatus: RequestStatus.success,
          damageCostData: costs,
        ),
      );
    } catch (e) {
      emit(state.copyWith(getAllDamageCostStatus: RequestStatus.failure));
      _handleError(e, emit);
    }
  }

  void _handleError(dynamic error, Emitter<ProductCostState> emit) {
    int statusCode = 500;
    String message = error.toString();

    if (error is FetchDataException) {
      statusCode = 500;
    } else if (error is UnAuthorizedException) {
      statusCode = 401;
    } else if (error is DoesNotExistException) {
      statusCode = 404;
    } else if (error is ServerValidationError) {
      statusCode = 400;
    } else if (error is ServerValidationError) {
      statusCode = 503;
    } else {
      statusCode = 500;
    }

    emit(state.copyWith(statusCode: statusCode, errorMessage: message));
  }
}

class CustomException implements Exception {
  final dynamic _message;
  final dynamic _prefix;

  CustomException(this._message, this._prefix);

  @override
  String toString() {
    return "$_prefix:$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message]) : super(message, "");
}

class UnAuthorizedException extends CustomException {
  UnAuthorizedException([String? message]) : super(message, "");
}

class DoesNotExistException extends CustomException {
  DoesNotExistException([String? message]) : super(message, "");
}

class ServerValidationError extends CustomException {
  ServerValidationError([String? message]) : super(message, "");
}

class underMaintenanceError extends CustomException {
  underMaintenanceError([String? message]) : super(message, "");
}

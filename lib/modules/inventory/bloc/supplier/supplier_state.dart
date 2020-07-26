part of 'supplier_bloc.dart';

abstract class SupplierState extends Equatable {
  const SupplierState();
}

class SupplierInitial extends SupplierState {
  @override
  List<Object> get props => [];
}

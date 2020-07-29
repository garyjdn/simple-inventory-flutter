part of 'supplier_bloc.dart';

abstract class SupplierEvent extends Equatable {
  const SupplierEvent();
}

class LoadSupplierStarted extends SupplierEvent {
  @override
  List<Object> get props => [];
  
}

class DeleteSupplierButtonPressed extends SupplierEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}
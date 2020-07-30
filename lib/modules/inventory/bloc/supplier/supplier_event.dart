part of 'supplier_bloc.dart';

abstract class SupplierEvent extends Equatable {
  const SupplierEvent();
}

class LoadSupplierStarted extends SupplierEvent {
  @override
  List<Object> get props => [];
  
}

class DeleteSupplierButtonPressed extends SupplierEvent {
  final Supplier supplier;

  DeleteSupplierButtonPressed({this.supplier}): assert(supplier != null);

  @override
  List<Object> get props => throw UnimplementedError();
}
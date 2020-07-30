part of 'supplier_bloc.dart';

abstract class SupplierState extends Equatable {
  const SupplierState();
}

class SupplierInitial extends SupplierState {
  @override
  List<Object> get props => [];
}

class SupplierLoadStarted extends SupplierState {
  @override
  List<Object> get props => [];

}

class SupplierLoadSuccess extends SupplierState {
  final List<Supplier> suppliers;

  SupplierLoadSuccess({
    @required this.suppliers
  }):
    assert(suppliers != null);

  @override
  List<Object> get props => [];
}

class SupplierLoadFailure extends SupplierState {
  final String title;
  final String message;

  SupplierLoadFailure({
    this.title,
    @required this.message
  }):
    assert(message != null && message.isNotEmpty);

  @override
  List<Object> get props => [];
}

class SupplierDeleteSuccess extends SupplierState {
  final String message;

  SupplierDeleteSuccess({
    this.message
  });

  @override
  List<Object> get props => [];
}
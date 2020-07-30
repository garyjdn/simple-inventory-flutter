part of 'supplier_form_bloc.dart';

abstract class SupplierFormState extends Equatable {
  const SupplierFormState();
}

class SupplierFormInitial extends SupplierFormState {
  @override
  List<Object> get props => [];
}

class SupplierFormSubmitInProgress extends SupplierFormState {
  @override
  List<Object> get props => [];
}

class SupplierFormSubmitSuccess extends SupplierFormState {
  final String message;

  SupplierFormSubmitSuccess({this.message});

  @override
  List<Object> get props => [];
}
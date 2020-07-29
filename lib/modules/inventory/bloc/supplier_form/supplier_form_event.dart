part of 'supplier_form_bloc.dart';

abstract class SupplierFormEvent extends Equatable {
  const SupplierFormEvent();
}

class AddSupplierButtonPressed extends SupplierFormEvent {
  final String name;
  final String phone;
  final String address;

  AddSupplierButtonPressed({
    @required this.name,
    @required this.phone,
    @required this.address,
  }):
    assert(name != null && name.isNotEmpty),
    assert(phone != null && phone.isNotEmpty),
    assert(address != null && address.isNotEmpty);

  @override
  List<Object> get props => throw UnimplementedError();
}

class EditSupplierButtonPressed extends SupplierFormEvent {
  final Supplier supplier;

  EditSupplierButtonPressed({
    @required this.supplier,
  }):
    assert(supplier != null);

  @override
  List<Object> get props => throw UnimplementedError();
}

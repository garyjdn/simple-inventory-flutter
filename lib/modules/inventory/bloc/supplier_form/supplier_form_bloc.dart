import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';

part 'supplier_form_event.dart';
part 'supplier_form_state.dart';

class SupplierFormBloc extends Bloc<SupplierFormEvent, SupplierFormState> {
  SupplierFormBloc() : super(SupplierFormInitial());

  @override
  Stream<SupplierFormState> mapEventToState(
    SupplierFormEvent event,
  ) async* {
    if(event is AddSupplierButtonPressed) {
      yield* _addSupplier(event);
    } else if(event is EditSupplierButtonPressed) {
      yield* _editSupplier(event);
    }
  }

  Stream<SupplierFormState> _addSupplier(AddSupplierButtonPressed event) async* {
    yield SupplierFormSubmitInProgress();
    SupplierRepository _supplierRepository = SupplierRepository();
    await _supplierRepository.createSupplier(
      name: event.name,
      phone: event.phone,
      address: event.address,
    );
    yield SupplierFormSubmitSuccess(message: 'Supplier Created');
  }

  Stream<SupplierFormState> _editSupplier(EditSupplierButtonPressed event) async* {
    yield SupplierFormSubmitInProgress();
    SupplierRepository _supplierRepository = SupplierRepository();
    await _supplierRepository.updateSupplier(supplier: event.supplier);
    yield SupplierFormSubmitSuccess(message: 'Supplier Updated');
  }
}

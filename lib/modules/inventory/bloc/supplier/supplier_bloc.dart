import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';

part 'supplier_event.dart';
part 'supplier_state.dart';

class SupplierBloc extends Bloc<SupplierEvent, SupplierState> {
  SupplierBloc() : super(SupplierInitial());

  @override
  Stream<SupplierState> mapEventToState(
    SupplierEvent event,
  ) async* {
    if(event is LoadSupplierStarted) {
      yield* _loadSupplierStarted(event);
    }
  }

  Stream<SupplierState> _loadSupplierStarted(LoadSupplierStarted event) async* {
    yield SupplierLoadStarted();
    SupplierRepository _supplierRepository = SupplierRepository();
    List<Supplier> suppliers = await _supplierRepository.getAllData();
    yield SupplierLoadSuccess(suppliers: suppliers);
  }
}

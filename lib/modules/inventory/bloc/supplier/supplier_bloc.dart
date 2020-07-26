import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'supplier_event.dart';
part 'supplier_state.dart';

class SupplierBloc extends Bloc<SupplierEvent, SupplierState> {
  SupplierBloc() : super(SupplierInitial());

  @override
  Stream<SupplierState> mapEventToState(
    SupplierEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'request_item_event.dart';
part 'request_item_state.dart';

class RequestItemBloc extends Bloc<RequestItemEvent, RequestItemState> {
  RequestItemBloc() : super(RequestItemInitial());

  @override
  Stream<RequestItemState> mapEventToState(
    RequestItemEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';

part 'request_item_event.dart';
part 'request_item_state.dart';

class RequestItemBloc extends Bloc<RequestItemEvent, RequestItemState> {
  RequestItemBloc() : super(RequestItemInitial());

  @override
  Stream<RequestItemState> mapEventToState(
    RequestItemEvent event,
  ) async* {
    if(event is LoadRequestItemStarted) {
      yield* _loadRequestItemStarted(event);
    } else if(event is DeleteRequestItemButtonPressed) {
      yield* _deleteRequestItem(event);
    } else if(event is AddRequestItemButtonPressed) {
      yield* _addRequestItem(event);
    } 
    // else if(event is EditRequestItemButtonPressed) {
    //   yield* _editRequestItem(event);
    // }
  }

  Stream<RequestItemState> _loadRequestItemStarted(LoadRequestItemStarted event) async* {
    yield RequestItemLoadStarted();
    RequestRepository _requestItemRepository = RequestRepository();
    List<RequestItem> requestItems = await _requestItemRepository.getAllData(event.user);
    
    requestItems.map((request) async {
      UserRepository _userRepository = UserRepository();
      User user = await _userRepository.getUser(uid: request.requestUser);
      request.requestUser = user;
    });
    
    StationRepository _stationRepository = StationRepository();
    List<Station> stations = await _stationRepository.getAllData();

    yield RequestItemLoadSuccess(
      requestItems: requestItems,
      stations: stations
    );
  }

  Stream<RequestItemState> _deleteRequestItem(DeleteRequestItemButtonPressed event) async* {
    yield RequestItemLoadStarted();
    RequestRepository _requestItemRepository = RequestRepository();
    await _requestItemRepository.deleteRequestItem(event.requestItem);
    yield RequestItemDeleteSuccess(message: 'Request deleted');
  }

  Stream<RequestItemState> _addRequestItem(AddRequestItemButtonPressed event) async* {
    yield RequestItemSubmitInProgress();
    RequestRepository _requestItemRepository = RequestRepository();
    RequestItem requestItem = await _requestItemRepository.createRequestItem(
      station: event.station,
      user: event.user,
    );
    yield RequestItemSubmitSuccess(requestItem: requestItem);
  }

  // Stream<RequestItemState> _editRequestItem(EditRequestItemButtonPressed event) async* {
  //   yield RequestItemSubmitInProgress();
  //   RequestRepository _requestItemRepository = RequestRepository();
  //   await _requestItemRepository.updateRequestItem(request: event.requestItem);
  //   yield RequestItemSubmitSuccess(message: 'Request Updated');
  // }
}

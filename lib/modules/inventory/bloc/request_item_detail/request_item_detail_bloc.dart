import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';

part 'request_item_detail_event.dart';
part 'request_item_detail_state.dart';

class RequestItemDetailBloc extends Bloc<RequestItemDetailEvent, RequestItemDetailState> {
  RequestItemDetailBloc() : super(RequestItemDetailInitial());

  @override
  Stream<RequestItemDetailState> mapEventToState(
    RequestItemDetailEvent event,
  ) async* {
    if(event is LoadRequestItemDetailStarted) {
      yield* _loadRequestItemDetailStarted(event);
    } else if(event is DeleteRequestItemDetailButtonPressed) {
      yield* _deleteRequestItemDetail(event);
    } else  if(event is AddRequestItemDetailButtonPressed) {
      yield* _addRequestDetail(event);
    } else if(event is EditRequestItemDetailButtonPressed) {
      yield* _editRequestDetail(event);
    } else if(event is EditRequestItemButtonPressed) {
      yield* _editRequestItem(event);
    } 
  }

  Stream<RequestItemDetailState> _loadRequestItemDetailStarted(LoadRequestItemDetailStarted event) async* {
    yield RequestItemDetailLoadStarted();
    RequestDetailRepository _requestDetailRepository = RequestDetailRepository();
    List<RequestItemDetail> requestItemDetails = await _requestDetailRepository.getRequestDetailByRequestId(requestItem: event.requestItem);

    ItemRepository _itemRepository = ItemRepository();
    List<Item> items = await _itemRepository.getAllData();

    yield RequestItemDetailLoadSuccess(
      requestItemDetails: requestItemDetails,
      items: items
    );
  }

  Stream<RequestItemDetailState> _deleteRequestItemDetail(DeleteRequestItemDetailButtonPressed event) async* {
    yield RequestItemDetailLoadStarted();
    RequestDetailRepository _requestDetailRepository = RequestDetailRepository();
    await _requestDetailRepository.deleteRequestDetail(event.requestItemDetail);
    yield RequestItemDetailDeleteSuccess(message: 'RequestItemDetail deleted');
  }

  Stream<RequestItemDetailState> _addRequestDetail(AddRequestItemDetailButtonPressed event) async* {
    yield RequestItemDetailSubmitInProgress();
    RequestDetailRepository _requestDetailRepository = RequestDetailRepository();
    await _requestDetailRepository.createRequestDetail(
      requestItem: event.requestItem,
      item: event.item,
      amount: event.amount
    );
    yield RequestItemDetailSubmitSuccess(message: 'Request Item Added');
  }

  Stream<RequestItemDetailState> _editRequestDetail(EditRequestItemDetailButtonPressed event) async* {
    yield RequestItemDetailSubmitInProgress();
    RequestDetailRepository _requestDetailRepository = RequestDetailRepository();
    await _requestDetailRepository.updateRequestDetail(requestItemDetail: event.requestItemDetail);
    yield RequestItemDetailSubmitSuccess(message: 'Request Item Updated');
  }

  Stream<RequestItemDetailState> _editRequestItem(EditRequestItemButtonPressed event) async* {
    yield RequestItemDetailSubmitInProgress();
    RequestRepository _requestItemRepository = RequestRepository();
    await _requestItemRepository.updateRequestItem(request: event.requestItem);
    yield RequestItemDetailSubmitStatusSuccess(message: 'Request Updated');
  }
}

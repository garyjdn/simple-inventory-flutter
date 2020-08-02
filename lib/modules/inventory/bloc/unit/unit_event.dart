part of 'unit_bloc.dart';

abstract class UnitEvent extends Equatable {
  const UnitEvent();
}

class LoadUnitStarted extends UnitEvent {
  @override
  List<Object> get props => [];
  
}

class DeleteUnitButtonPressed extends UnitEvent {
  final Unit unit;

  DeleteUnitButtonPressed({this.unit}): assert(unit != null);

  @override
  List<Object> get props => throw UnimplementedError();
}
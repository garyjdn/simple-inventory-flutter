part of 'unit_bloc.dart';

abstract class UnitState extends Equatable {
  const UnitState();
}

class UnitInitial extends UnitState {
  @override
  List<Object> get props => [];
}

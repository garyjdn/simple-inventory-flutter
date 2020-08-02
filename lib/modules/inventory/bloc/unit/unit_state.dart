part of 'unit_bloc.dart';

abstract class UnitState extends Equatable {
  const UnitState();
}

class UnitInitial extends UnitState {
  @override
  List<Object> get props => [];
}

class UnitLoadStarted extends UnitState {
  @override
  List<Object> get props => [];

}

class UnitLoadSuccess extends UnitState {
  final List<Unit> units;

  UnitLoadSuccess({
    @required this.units
  }):
    assert(units != null);

  @override
  List<Object> get props => [];
}

class UnitLoadFailure extends UnitState {
  final String title;
  final String message;

  UnitLoadFailure({
    this.title,
    @required this.message
  }):
    assert(message != null && message.isNotEmpty);

  @override
  List<Object> get props => [];
}

class UnitDeleteSuccess extends UnitState {
  final String message;

  UnitDeleteSuccess({
    this.message
  });

  @override
  List<Object> get props => [];
}
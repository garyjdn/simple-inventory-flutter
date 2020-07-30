part of 'unit_form_bloc.dart';

abstract class UnitFormEvent extends Equatable {
  const UnitFormEvent();
}

class AddUnitButtonPressed extends UnitFormEvent {
  final String name;

  AddUnitButtonPressed({
    @required this.name,
  }):
    assert(name != null && name.isNotEmpty);

  @override
  List<Object> get props => throw UnimplementedError();
}

class EditUnitButtonPressed extends UnitFormEvent {
  final Unit unit;

  EditUnitButtonPressed({
    @required this.unit,
  }):
    assert(unit != null);

  @override
  List<Object> get props => throw UnimplementedError();
}

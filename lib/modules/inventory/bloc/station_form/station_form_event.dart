part of 'station_form_bloc.dart';

abstract class StationFormEvent extends Equatable {
  const StationFormEvent();
}

class AddStationButtonPressed extends StationFormEvent {
  final String name;

  AddStationButtonPressed({
    @required this.name
  }):
    assert(name != null && name.isNotEmpty);

  @override
  List<Object> get props => throw UnimplementedError();
}

class EditStationButtonPressed extends StationFormEvent {
  final Station station;

  EditStationButtonPressed({
    @required this.station,
  }):
    assert(station != null);

  @override
  List<Object> get props => throw UnimplementedError();
}

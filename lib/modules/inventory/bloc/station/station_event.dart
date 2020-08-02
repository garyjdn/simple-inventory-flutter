part of 'station_bloc.dart';

abstract class StationEvent extends Equatable {
  const StationEvent();
}

class LoadStationStarted extends StationEvent {
  @override
  List<Object> get props => [];
  
}

class DeleteStationButtonPressed extends StationEvent {
  final Station station;

  DeleteStationButtonPressed({this.station}): assert(station != null);

  @override
  List<Object> get props => throw UnimplementedError();
}
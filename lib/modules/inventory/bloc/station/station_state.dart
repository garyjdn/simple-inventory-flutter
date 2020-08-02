part of 'station_bloc.dart';

abstract class StationState extends Equatable {
  const StationState();
}

class StationInitial extends StationState {
  @override
  List<Object> get props => [];
}

class StationLoadStarted extends StationState {
  @override
  List<Object> get props => [];

}

class StationLoadSuccess extends StationState {
  final List<Station> stations;

  StationLoadSuccess({
    @required this.stations
  }):
    assert(stations != null);

  @override
  List<Object> get props => [];
}

class StationLoadFailure extends StationState {
  final String title;
  final String message;

  StationLoadFailure({
    this.title,
    @required this.message
  }):
    assert(message != null && message.isNotEmpty);

  @override
  List<Object> get props => [];
}

class StationDeleteSuccess extends StationState {
  final String message;

  StationDeleteSuccess({
    this.message
  });

  @override
  List<Object> get props => [];
}
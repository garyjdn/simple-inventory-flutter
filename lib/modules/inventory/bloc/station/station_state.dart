part of 'station_bloc.dart';

abstract class StationState extends Equatable {
  const StationState();
}

class StationInitial extends StationState {
  @override
  List<Object> get props => [];
}

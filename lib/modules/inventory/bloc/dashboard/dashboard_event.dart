part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}

class DashboardStarted extends DashboardEvent {
  @override
  List<Object> get props => [];
}

class DashboardRefreshed extends DashboardEvent {
  @override
  List<Object> get props => null;
}
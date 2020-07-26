part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
}

class DashboardInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardLoadInProgress extends DashboardState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DashboardLoadSuccess extends DashboardState {
  // final PickingDashboard pickingDashboard;

  // PickingDashboardLoadSuccess({@required this.pickingDashboard}):
  //   assert(pickingDashboard != null);

  @override
  List<Object> get props => [];
}

class DashboardLoadFailure extends DashboardState {
  final int code;
  final String title;
  final String message;

  DashboardLoadFailure({
    this.code,
    this.title,
    @required this.message
  }):
    assert(message != null && message.isNotEmpty);

  @override
  // TODO: implement props
  List<Object> get props => [code, title, message];

}
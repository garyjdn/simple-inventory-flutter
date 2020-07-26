part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}

class AppStarted extends AppEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];

}
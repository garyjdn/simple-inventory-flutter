part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();
}

class AppInitial extends AppState {
  @override
  List<Object> get props => [];
}

class AppLoading extends AppState {
  @override
  // TODO: implement props
  List<Object> get props => null;

}

class AppInformationLoaded extends AppState {
  final String version;

  AppInformationLoaded({@required this.version}):
    assert(version != null && version.isNotEmpty);
    
  @override
  // TODO: implement props
  List<Object> get props => null;

}
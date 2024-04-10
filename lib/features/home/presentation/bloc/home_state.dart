part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeDataLoading extends HomeState {}

class HomeDataError extends HomeState {
  final String message ;
  HomeDataError({
    required this.message,
  });
}

class HomeDataLoaded extends HomeState {
  final List data ;
  HomeDataLoaded({
    required this.data,
  });
}

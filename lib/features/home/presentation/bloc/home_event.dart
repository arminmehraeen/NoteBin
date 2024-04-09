part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeDataLoad extends HomeEvent {
  final BuildContext context ;

  HomeDataLoad({
    required this.context,
  });
}

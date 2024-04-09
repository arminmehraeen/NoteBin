part of 'intro_cubit.dart';

@immutable
abstract class IntroState {}

class IntroLoading extends IntroState {}

class IntroNoConnection extends IntroState {}

class IntroOk extends IntroState {
  final bool isLogin ;
  IntroOk({
    this.isLogin = false,
  });
}
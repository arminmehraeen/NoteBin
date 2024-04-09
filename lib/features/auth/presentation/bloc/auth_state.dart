part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthMain extends AuthState {

  final String? message ;
  final bool isLogin ;
  final bool isRegister ;
  final bool isLogout ;

  AuthMain({
    this.message,
    this.isLogin = false,
    this.isLogout = false,
    this.isRegister = false
  });

}

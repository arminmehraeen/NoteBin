import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notebin/core/resources/data_state.dart';
import 'package:notebin/features/auth/domain/entities/login_entity.dart';
import 'package:notebin/features/auth/domain/entities/register_entity.dart';

import '../../domain/use_case/auth_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUseCase authUseCase;

  AuthCubit({required this.authUseCase}) : super(AuthMain());

  Future login(LoginEntity entity) async {
    var data = await authUseCase.login(entity);

    if (data is DataSuccess) {
      emit(AuthMain(isLogin: true));
    }

    if (data is DataFailed) {
      emit(AuthMain(message: "Login unSuccessfully"));
    }

  }

  Future logout() async {
    var data = await authUseCase.logout();

    if (data is DataSuccess) {
      emit(AuthMain(isLogout: true));
    }

    if (data is DataFailed) {
      emit(AuthMain(message: "Logout unSuccessfully"));
    }
  }

  Future register(RegisterEntity entity) async {
    if (entity.password != entity.passwordConfirmation) {
      emit(AuthMain(message: "password confirmation not match to password"));
    }

    var data = await authUseCase.register(entity);

    if (data is DataSuccess) {
      emit(AuthMain(isRegister: true));
    }

    if (data is DataFailed) {
      emit(AuthMain(message: "Login unSuccessfully"));
    }
  }
}


import 'package:get_it/get_it.dart';
import 'package:notebin/features/auth/domain/use_case/auth_usecase.dart';
import 'package:notebin/features/auth/presentation/bloc/auth_cubit.dart';


class AuthLocator {

  AuthLocator(GetIt locator) {
    locator.registerSingleton<AuthCubit>(AuthCubit(authUseCase: AuthUseCase(apiService: locator(),storageService: locator())));
  }

}

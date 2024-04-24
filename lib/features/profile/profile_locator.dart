import 'package:get_it/get_it.dart';
import 'package:notebin/features/profile/domain/use_case/profile_usecase.dart';
import 'package:notebin/features/profile/presentation/bloc/profile_bloc.dart';

class ProfileLocator {
  ProfileLocator(GetIt locator) {
    ProfileUseCase profileUseCase = ProfileUseCase(storageService: locator()) ;
    locator.registerSingleton(ProfileBloc(profileUseCase)) ;
  }

}
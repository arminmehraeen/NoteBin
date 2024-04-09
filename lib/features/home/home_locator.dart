import 'package:get_it/get_it.dart';
import 'package:notebin/features/home/domain/use_case/home_usecase.dart';
import 'package:notebin/features/home/presentation/bloc/home_bloc.dart';

class HomeLocator {

  HomeLocator(GetIt locator) {
    var homeUseCase = HomeUseCase(apiService: locator(), storageService: locator()) ;
    locator.registerSingleton(HomeBloc(homeUseCase: homeUseCase)) ;
  }

}

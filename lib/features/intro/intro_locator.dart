import 'package:get_it/get_it.dart';
import 'presentation/cubit/intro_cubit.dart';

class IntroLocator {

  IntroLocator(GetIt locator) {
    locator.registerSingleton<IntroCubit>(IntroCubit(storageService: locator(),connectionService: locator()));
  }

}

import 'package:get_it/get_it.dart';
import 'package:notebin/features/home/presentation/cubit/home_cubit.dart';

class HomeLocator {
  HomeLocator(GetIt locator) {
    locator.registerSingleton(HomeCubit()) ;
  }
}
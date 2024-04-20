import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:notebin/features/auth/auth_locator.dart';
import 'package:notebin/features/home/presentation/home_locator.dart';
import 'package:notebin/features/intro/intro_locator.dart';
import 'package:notebin/features/post/post_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/bloc/theme/theme_cubit.dart';
import '../core/services/api_service.dart';
import '../core/services/connection_service.dart';
import '../core/services/storage_service.dart';
import '../features/profile/profile_locator.dart';

GetIt locator = GetIt.instance;

setup() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  locator.registerSingleton<StorageService>(StorageService(prefs: prefs));
  locator.registerSingleton<Dio>(Dio());

  locator.registerSingleton<ConnectionService>(ConnectionService());

  locator.registerSingleton<ThemeCubit>(ThemeCubit(storageService: locator()));

  locator.registerSingleton(ApiService(storageService: locator())) ;

  IntroLocator(locator) ;
  HomeLocator(locator) ;
  AuthLocator(locator)  ;
  PostLocator(locator)  ;
  ProfileLocator(locator)  ;
}

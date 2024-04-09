import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/services/connection_service.dart';
import '../../../../core/services/storage_service.dart';

part 'intro_state.dart';

class IntroCubit extends Cubit<IntroState> {
  final ConnectionService connectionService;
  final StorageService storageService ;


  IntroCubit({required this.connectionService,required this.storageService}) : super(IntroLoading());


  Future<void> initCheck() async {
    emit(IntroLoading());
    await Future.delayed(const Duration(seconds: 1));
    bool isConnected = await connectionService.check();
    emit(isConnected ? IntroOk(
      isLogin: storageService.loadToken() != null
    ) : IntroNoConnection());
  }
}

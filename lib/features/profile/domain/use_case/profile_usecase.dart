import 'dart:convert';

import 'package:notebin/core/models/user_model.dart';
import 'package:notebin/core/services/storage_service.dart';

import '../../../../core/resources/data_state.dart';

class ProfileUseCase {

  final StorageService storageService ;

  const ProfileUseCase({
    required this.storageService,
  });


  Future<DataState> profile () async  {

    String? stringUser = storageService.loadUser() ;
    if(stringUser != null) {
      UserModel userModel = UserModel.fromMap(json.decode(stringUser));
      return DataSuccess(data: userModel) ;
    }

    return const DataFailed(error: "") ;
  }
}
import 'dart:convert';

import 'package:notebin/core/models/user_model.dart';
import 'package:notebin/core/services/api_service.dart';
import 'package:notebin/core/utils/constants.dart';
import 'package:notebin/features/auth/domain/entities/login_entity.dart';
import 'package:notebin/features/auth/domain/entities/register_entity.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/services/storage_service.dart';

class AuthUseCase  {

  final ApiService apiService ;
  final StorageService storageService ;
  AuthUseCase({required this.apiService,required this.storageService}) ;


  Future<DataState<bool>> login (LoginEntity entity) async {
    var response = await apiService.post(ApiPath.login,isAuth: false,data: entity.toMap()) ;
    if(response.statusCode == 200) {
      await saveInformation(response) ;
      return const DataSuccess(data: true) ;
    }
    return const DataFailed(error: "") ;
  }


  Future<DataState<bool>> logout () async {
    var response = await apiService.post(ApiPath.logout) ;

    if(response.statusCode == 200) {
      await storageService.removeToken() ;
      return const DataSuccess(data: true) ;
    }

    return const DataFailed(error: "") ;
  }


  Future saveInformation(response) async {
    await storageService.saveToken(token: response.data['data']['token']) ;
    UserModel user = UserModel.fromMap(response.data['data']['user']) ;
    await storageService.saveUser(user: json.encode(user.toMap())) ;
  }


  Future<DataState<bool>> register (RegisterEntity entity) async {
    var response = await apiService.post(ApiPath.register,isAuth: false,data: entity.toMap()) ;
    if(response.statusCode == 201) {
      await saveInformation(response) ;
      return const DataSuccess(data: true) ;
    }
    return const DataFailed(error: "") ;
  }

}
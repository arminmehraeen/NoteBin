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
      String token = response.data['data']['token'];
      await storageService.saveToken(token: token) ;
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

  Future<DataState<bool>> register (RegisterEntity entity) async {

    var response = await apiService.post(ApiPath.register,isAuth: false,data: entity.toMap()) ;

    if(response.statusCode == 201) {
      return const DataSuccess(data: true) ;
    }
    return const DataFailed(error: "") ;
  }

}
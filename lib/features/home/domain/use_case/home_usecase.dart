import 'package:notebin/core/services/api_service.dart';
import 'package:notebin/core/utils/constants.dart';
import 'package:notebin/features/auth/domain/entities/login_entity.dart';
import 'package:notebin/features/auth/domain/entities/register_entity.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/services/storage_service.dart';

class HomeUseCase  {

  final ApiService apiService ;
  final StorageService storageService ;
  HomeUseCase({required this.apiService,required this.storageService}) ;


  Future<DataState> posts () async {

    var response = await apiService.get(ApiPath.posts) ;

    if(response.statusCode == 200) {
      return DataSuccess(data: response.data) ;
    }
    return const DataFailed(error: "") ;
  }


}
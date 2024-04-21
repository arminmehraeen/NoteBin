import 'package:dio/dio.dart';
import 'package:notebin/core/services/api_service.dart';
import 'package:notebin/core/utils/constants.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/services/storage_service.dart';

class PostUseCase  {

  final ApiService apiService ;
  final StorageService storageService ;
  PostUseCase({required this.apiService,required this.storageService}) ;


  Future<DataState> posts () async {

    var response = await apiService.get(ApiPath.posts) ;

    if(response.statusCode == 200) {
      return DataSuccess(data: response.data) ;
    }
    return const DataFailed(error: "") ;
  }

  Future<DataState> commends ({required int postId}) async {


    var response = await apiService.get("${ApiPath.commends}/?post_id=$postId" ) ;

    if(response.statusCode == 200) {
      return DataSuccess(data: response.data) ;
    }
    return const DataFailed(error: "") ;
  }

  Future<DataState> addPost ({required String title , required String body,MultipartFile? postFile}) async {

    var response ;

    response = await apiService.post(ApiPath.posts,data: {
      "title" : title ,
      "body" : body ,
      if(postFile != null) "image" : postFile
    }) ;

    if(response.statusCode == 201) {
      return DataSuccess(data: response.data) ;
    }
    return const DataFailed(error: "") ;
  }

  Future<DataState> deletePost ({required String id}) async {


    var response = await apiService.delete("${ApiPath.posts}/$id") ;

    if(response.statusCode == 200) {
      return DataSuccess(data: response.data) ;
    }
    return const DataFailed(error: "") ;
  }


  Future<DataState> addComment ({required String comment , required int postId,int? commendId}) async {

    var response = await apiService.post(ApiPath.commends,data: {
      "message" : comment ,
      "post_id" : postId  ,
      if(commendId != null) "commend_id" : commendId
    }) ;

    if(response.statusCode == 201) {
      return DataSuccess(data: response.data) ;
    }
    return const DataFailed(error: "") ;
  }

  deleteComment({required int commendId}) async {

    var response = await apiService.delete("${ApiPath.commends}/$commendId") ;
    if(response.statusCode == 200) {
      return DataSuccess(data: response.data) ;
    }
    return const DataFailed(error: "") ;
  }


}
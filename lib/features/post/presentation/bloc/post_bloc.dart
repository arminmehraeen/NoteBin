import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../core/models/action_status.dart';
import '../../../../core/models/commend_model.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/utils/app_ui_helper.dart';
import '../../domain/use_case/post_usecase.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {


  final PostUseCase postUseCase ;
  final StorageService stroageService ;

  PostBloc({required this.postUseCase,required this.stroageService}) : super(PostState.init()) {

    on<LoadPosts>((event, emit) async {

      emit(PostState.init());

      var dataState = await postUseCase.posts();

      if (dataState is DataSuccess) {
        emit(state.copyWith(posts: ActionSuccess(dataState.data['data']))) ;
      }

      if (dataState is DataFailed) {
        emit(state.copyWith(posts: ActionError())) ;
      }

    });


    on<LoadCommends>((event, emit) async {

      if(event.showLoad) {
        emit(state.copyWith(commendsOfPost: ActionWait(),addComment: ActionWait()));
      }else {
        emit(state.copyWith(addComment: ActionWait()));
      }

      var dataState = await postUseCase.commends(postId: event.postId);
      if (dataState is DataSuccess) {
        List data = dataState.data['data'] ;
        String? userString = stroageService.loadUser() ;
        UserModel? user;
        if(userString != null) {
          user = UserModel.fromMap(json.decode(userString)) ;
        }
        List<CommendModel> commends = data.map((e) => CommendModel.fromMap(e,user?.id)).toList() ;
        emit(state.copyWith(commendsOfPost: ActionSuccess<List<CommendModel>>(commends)));
      }
      if (dataState is DataFailed) {
        emit(state.copyWith(commendsOfPost: ActionError())) ;
      }
    });


    on<AddPost>((event, emit) async {
      showLoadingDialog(context: event.context);
      var dataState = await postUseCase.addPost(title: event.title, body: event.body,postFile: event.postFile);
      dismissibleDialog(context: event.context) ;
      if (dataState is DataSuccess) {
        emit(state.copyWith(addPost: ActionSuccess("add post successfully"))) ;
      }
      if (dataState is DataFailed) {
        emit(state.copyWith(addPost: ActionError())) ;
      }
    });

    on<AddComment>((event, emit) async {
      showLoadingDialog(context: event.context);



      int? commendId ;

      if(event.commend != null) {
        CommendModel commendModel = event.commend! ;
        if(commendModel.commend_id == null) {
          commendId = commendModel.id;
        }else{
          commendId = commendModel.commend_id;
        }
      }

      var dataState = await postUseCase.addComment(postId: event.postId,comment: event.comment,commendId: commendId);
      dismissibleDialog(context: event.context) ;
      if (dataState is DataSuccess) {
        emit(state.copyWith(addComment: ActionSuccess("add comment successfully"))) ;
      }
      if (dataState is DataFailed) {
        emit(state.copyWith(addComment: ActionError())) ;
      }
    });

    on<RefreshCommends>((event, emit) async {
      emit(state.copyWith());
    });

    on<DeleteCommend>((event, emit) async {
      showLoadingDialog(context: event.context);
      var dataState = await postUseCase.deleteComment(commendId: event.commendId);
      dismissibleDialog(context: event.context) ;
      if (dataState is DataSuccess) {
        emit(state.copyWith(addComment: ActionSuccess("delete comment successfully"))) ;
      }
      if (dataState is DataFailed) {
        emit(state.copyWith(addComment: ActionError())) ;
      }
    });


    on<DeletePost>((event, emit) async {
      var dataState = await postUseCase.deletePost(id: event.postId);
      if (dataState is DataSuccess) {
        emit(state.copyWith(deletePost: ActionSuccess("delete post successfully"))) ;
      }
      if (dataState is DataFailed) {
        emit(state.copyWith(deletePost: ActionError())) ;
      }
    });

  }
}

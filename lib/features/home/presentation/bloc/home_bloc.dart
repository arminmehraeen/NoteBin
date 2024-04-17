

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/utils/app_ui_helper.dart';
import '../../domain/use_case/home_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final HomeUseCase homeUseCase ;
  HomeBloc({required this.homeUseCase}) : super(HomeState.init()) {

    on<HomeDataLoad>((event, emit) async {
      emit(HomeState.init());
      var dataState = await homeUseCase.posts();
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

      var dataState = await homeUseCase.commends(postId: event.postId);
      if (dataState is DataSuccess) {
        List data = dataState.data['data'] ;
        emit(state.copyWith(commendsOfPost: ActionSuccess(data)));
      }
      if (dataState is DataFailed) {
        emit(state.copyWith(commendsOfPost: ActionError())) ;
      }
    });


    on<AddPost>((event, emit) async {
      showLoadingDialog(context: event.context);
      var dataState = await homeUseCase.addPost(title: event.title, body: event.body,postFile: event.postFile);
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
      var dataState = await homeUseCase.addComment(postId: event.postId,comment: event.comment);
      dismissibleDialog(context: event.context) ;
      if (dataState is DataSuccess) {
        emit(state.copyWith(addComment: ActionSuccess("add comment successfully"))) ;
      }
      if (dataState is DataFailed) {
        emit(state.copyWith(addComment: ActionError())) ;
      }
    });


    on<DeletePost>((event, emit) async {
      var dataState = await homeUseCase.deletePost(id: event.postId);
      if (dataState is DataSuccess) {
        emit(state.copyWith(deletePost: ActionSuccess("delete post successfully"))) ;
      }
      if (dataState is DataFailed) {
        emit(state.copyWith(deletePost: ActionError())) ;
      }
    });

  }
}

import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/utils/app_ui_helper.dart';
import '../../domain/use_case/home_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final HomeUseCase homeUseCase ;
  HomeBloc({required this.homeUseCase}) : super(HomeDataLoading()) {

    on<HomeDataLoad>((event, emit) async {

      emit(HomeDataLoading());

      var dataState = await homeUseCase.posts();

      if (dataState is DataSuccess) {
        emit(HomeDataLoaded(data: dataState.data['data'])) ;
      }

      if (dataState is DataFailed) {
        emit(HomeDataError(message: dataState.error!)) ;
      }


    });

  }
}
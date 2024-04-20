import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../domain/entity/tab_item_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState(index: 0,tabs: [
    TabItemModel(index: 0, iconData: Icons.home, label: "Home"),
    TabItemModel(index: 1, iconData: Icons.add, label: "New"),
    TabItemModel(index: 2, iconData: Icons.person, label: "Profile"),
  ]));


  void changeIndex (int index) {
    emit(state.copyWith(index: index)) ;
  }
}

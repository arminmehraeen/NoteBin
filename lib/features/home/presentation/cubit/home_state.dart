part of 'home_cubit.dart';

class HomeState {

  final int index ;
  final List<TabItemModel> tabs;

  const HomeState({
    required this.index,
    required this.tabs,
  });

  HomeState copyWith({
    int? index,
    List<TabItemModel>? tabs
  }) {
    return HomeState(
      index: index ?? this.index,
      tabs: tabs ?? this.tabs,
    );
  }
}


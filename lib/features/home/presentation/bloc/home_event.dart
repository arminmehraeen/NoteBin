part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeDataLoad extends HomeEvent {
  final BuildContext context ;
  HomeDataLoad({
    required this.context,
  });
}

class DeletePost extends HomeEvent {
  final BuildContext context ;
  final String postId ;

  DeletePost({
    required this.context,
    required this.postId,
  });
}


class AddPost extends HomeEvent {
  final BuildContext context ;
  final String title ;
  final String body ;
  AddPost({
    required this.context,
    required this.title,
    required this.body,
  });
}


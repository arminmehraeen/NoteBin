part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeDataLoad extends HomeEvent {

}

class DeletePost extends HomeEvent {
  final BuildContext context ;
  final String postId ;

  DeletePost({
    required this.context,
    required this.postId,
  });
}

class LoadCommends extends HomeEvent {
  final BuildContext context ;
  final int postId ;
  final bool showLoad ;

  LoadCommends({
    required this.context,
    required this.postId,
    this.showLoad = true,
  });
}

class AddPost extends HomeEvent {
  final BuildContext context ;
  final String title ;
  final String body ;
  final MultipartFile? postFile ;
  AddPost({
    required this.context,
    required this.title,
    required this.body,
    this.postFile,
  });
}

class AddComment extends HomeEvent {
  final BuildContext context ;
  final String comment;
  final int postId ;

   AddComment({
    required this.context,
    required this.comment,
    required this.postId,
  });
}


part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class LoadPosts extends PostEvent {}

class DeletePost extends PostEvent {
  final BuildContext context ;
  final String postId ;

  DeletePost({
    required this.context,
    required this.postId,
  });
}



class AddPost extends PostEvent {
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


/// Commends event

class AddComment extends PostEvent {
  final BuildContext context ;
  final String comment;
  final int postId ;
  final CommendModel? commend ;

  AddComment({
    required this.context,
    required this.comment,
    required this.postId,
    this.commend,
  });
}

class DeleteCommend extends PostEvent {
  final BuildContext context ;
  final int commendId ;
  DeleteCommend({
    required this.context,
    required this.commendId,
  });
}

class LoadCommends extends PostEvent {
  final BuildContext context ;
  final int postId ;
  final bool showLoad ;

  LoadCommends({
    required this.context,
    required this.postId,
    this.showLoad = true,
  });
}

class RefreshCommends extends PostEvent {

}
part of 'post_bloc.dart';


class CrudAction {
  final ActionStatus read  ;
  final ActionStatus create;
  final ActionStatus update;
  final ActionStatus delete;

  const CrudAction({
    required this.read,
    required this.create,
    required this.update,
    required this.delete,
  });

  static CrudAction init () => CrudAction(read: ActionWait(), create: ActionWait(), update: ActionWait(), delete: ActionWait()) ;

  CrudAction copyWith({
    ActionStatus? read,
    ActionStatus? create,
    ActionStatus? update,
    ActionStatus? delete,
  }) {
    return CrudAction(
      read: read ?? this.read,
      create: create ?? this.create,
      update: update ?? this.update,
      delete: delete ?? this.delete,
    );
  }
}


class PostState {

  final ActionStatus posts ;
  final ActionStatus commendsOfPost ;
  final ActionStatus addPost ;
  final ActionStatus addComment ;
  final ActionStatus deletePost ;
  final ActionStatus deleteCommend ;

  static PostState init () => PostState(
      addComment: ActionWait(),
      posts: ActionWait(), commendsOfPost: ActionWait(), addPost: ActionWait(),
      deletePost: ActionWait(),
    deleteCommend: ActionWait(),
  ) ;

  const PostState({
    required this.posts,
    required this.commendsOfPost,
    required this.addPost,
    required this.addComment,
    required this.deletePost,
    required this.deleteCommend,
  });

  PostState copyWith({
    ActionStatus? posts,
    ActionStatus? commendsOfPost,
    ActionStatus? addPost,
    ActionStatus? addComment,
    ActionStatus? deletePost,
    ActionStatus? deleteCommend,
  }) {
    return PostState(
      posts: posts ?? this.posts,
      commendsOfPost: commendsOfPost ?? this.commendsOfPost,
      addPost: addPost ?? this.addPost,
      addComment: addComment ?? this.addComment,
      deletePost: deletePost ?? this.deletePost,
      deleteCommend: deleteCommend ?? this.deleteCommend,
    );
  }

}



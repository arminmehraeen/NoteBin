part of 'home_bloc.dart';

abstract class ActionStatus {}
class ActionWait extends ActionStatus {}
class ActionSuccess<T> extends ActionStatus {
  final T data ;
  ActionSuccess(this.data) ;
}
class ActionError extends ActionStatus {}

class HomeState {

  final ActionStatus posts ;
  final ActionStatus commendsOfPost ;
  final ActionStatus addPost ;
  final ActionStatus addComment ;
  final ActionStatus deletePost ;

  static HomeState init () => HomeState(
      addComment: ActionWait(),
      posts: ActionWait(), commendsOfPost: ActionWait(), addPost: ActionWait(), deletePost: ActionWait()) ;

  const HomeState({
    required this.posts,
    required this.commendsOfPost,
    required this.addPost,
    required this.addComment,
    required this.deletePost,
  });

  HomeState copyWith({
    ActionStatus? posts,
    ActionStatus? commendsOfPost,
    ActionStatus? addPost,
    ActionStatus? addComment,
    ActionStatus? deletePost,
  }) {
    return HomeState(
      posts: posts ?? this.posts,
      commendsOfPost: commendsOfPost ?? this.commendsOfPost,
      addPost: addPost ?? this.addPost,
      addComment: addComment ?? this.addComment,
      deletePost: deletePost ?? this.deletePost,
    );
  }

}


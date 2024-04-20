abstract class ActionStatus {}

class ActionWait extends ActionStatus {}

class ActionSuccess<T> extends ActionStatus {
  final T data ;
  ActionSuccess(this.data) ;
}

class ActionError extends ActionStatus {

}
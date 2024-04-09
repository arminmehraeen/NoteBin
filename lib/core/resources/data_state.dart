
abstract class DataState<T>{
  final T? data;
  final String? error;

  const DataState({required this.data , required this.error});
}

class DataSuccess<T> extends DataState<T>{
  const DataSuccess({required T? data}) : super(data: data , error: null);
}

class DataFailed<T> extends DataState<T>{
  const DataFailed({required String error}) : super(data: null , error: error);
}
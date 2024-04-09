import 'package:dio/dio.dart';

class ApiResponse<T> {

  final Response<T>? response ;
  final bool is403 ;

  const ApiResponse({
    this.response,
    this.is403 = false,
  });
}
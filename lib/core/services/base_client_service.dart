import 'dart:async';
import 'package:dio/dio.dart';

import '../utils/constants.dart';

class BaseClientService {
  Response _onTimeOut() {
    return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 408,
        statusMessage: "Time Out");
  }

  Response _onCatch(error) {
    return Response(
        requestOptions: RequestOptions(path: ''),
        data: error,
        statusMessage: "Unknown error occurred ( onCatch )");
  }

  Future<Response> get(String url, {Map<String, String>? headers}) async {
    var dio = Dio();
    try {
      var response = await dio
          .getUri(Uri.parse(ApiPath.host + url),
              options: Options(headers: headers))
          .timeout(const Duration(seconds: Constants.defaultTimeOutDuration),
              onTimeout: _onTimeOut)
          .onError((DioException error, stackTrace) {
        return Response(
            requestOptions: error.requestOptions,
            data: error.response?.data,
            statusMessage: error.message,
            headers: error.response?.headers,
            statusCode: error.response?.statusCode);
      });
      return response;
    } catch (e) {
      return _onCatch(e);
    } finally {
      dio.close(force: true);
    }
  }

  Future<Response> post(String url,
      {Map<String, String>? headers, dynamic data}) async {
    var dio = Dio();
    try {
      var res = FormData.fromMap(data) ;
      var response = await dio
          .postUri(Uri.parse(ApiPath.host + url),
              data: res, options: Options(headers: headers))
          .timeout(const Duration(seconds: Constants.defaultTimeOutDuration),
              onTimeout: _onTimeOut)
          .onError((DioException error, stackTrace) {
        return Response(
            requestOptions: error.requestOptions,
            data: error.response?.data,
            statusMessage: error.message,
            headers: error.response?.headers,
            statusCode: error.response?.statusCode);
      });
      return response;
    } catch (e) {
      return _onCatch(e);
    } finally {
      dio.close(force: true);
    }
  }

  Future<Response> postFormData(String url,
      {Map<String, String>? headers, dynamic data}) async {
    var dio = Dio();
    try {
      var response = await dio
          .postUri(
            Uri.parse(ApiPath.host + url),
            data: FormData.fromMap(data),
            options: Options(headers: headers),
            onSendProgress: (count, total) {
              print("$count FROM $total");
              if (count == total) {
                print("UPLOAD SUCCESSFULLY");
              }
            },
          )
          .timeout(const Duration(seconds: Constants.defaultTimeOutDuration),
              onTimeout: _onTimeOut)
          .onError((DioException error, stackTrace) {
            return Response(
                requestOptions: error.requestOptions,
                data: error.response?.data,
                statusMessage: error.message,
                headers: error.response?.headers,
                statusCode: error.response?.statusCode);
          });
      return response;
    } catch (e) {
      return _onCatch(e);
    } finally {
      dio.close(force: true);
    }
  }

  Future<Response> patch(String url,
      {Map<String, String>? headers, dynamic data}) async {
    var dio = Dio();
    try {
      var response = await dio
          .patchUri(Uri.parse(ApiPath.host + url),
              data: data, options: Options(headers: headers))
          .timeout(const Duration(seconds: Constants.defaultTimeOutDuration),
              onTimeout: _onTimeOut)
          .onError((DioException error, stackTrace) {
        return Response(
            requestOptions: error.requestOptions,
            data: error.response?.data,
            statusMessage: error.message,
            headers: error.response?.headers,
            statusCode: error.response?.statusCode);
      });
      return response;
    } catch (e) {
      return _onCatch(e);
    } finally {
      dio.close(force: true);
    }
  }

  Future<Response> patchFormData(String url,
      {Map<String, String>? headers, dynamic data}) async {
    var dio = Dio();
    try {
      var response = await dio
          .patchUri(
            Uri.parse(ApiPath.host + url),
            data: FormData.fromMap(data),
            options: Options(headers: headers),
            onSendProgress: (count, total) {
              print("$count FROM $total");
              if (count == total) {
                print("UPLOAD SUCCESSFULLY");
              }
            },
          )
          .timeout(const Duration(seconds: Constants.defaultTimeOutDuration),
              onTimeout: _onTimeOut)
          .onError((DioException error, stackTrace) {
            return Response(
                requestOptions: error.requestOptions,
                data: error.response?.data,
                statusMessage: error.message,
                headers: error.response?.headers,
                statusCode: error.response?.statusCode);
          });
      return response;
    } catch (e) {
      return _onCatch(e);
    } finally {
      dio.close(force: true);
    }
  }

  Future<Response> put(String url,
      {Map<String, String>? headers, dynamic data}) async {
    var dio = Dio();
    try {
      var response = await dio
          .putUri(Uri.parse(ApiPath.host + url),
              data: data, options: Options(headers: headers))
          .timeout(const Duration(seconds: Constants.defaultTimeOutDuration),
              onTimeout: _onTimeOut)
          .onError((DioException error, stackTrace) {
        return Response(
            requestOptions: error.requestOptions,
            data: error.response?.data,
            statusMessage: error.message,
            headers: error.response?.headers,
            statusCode: error.response?.statusCode);
      });
      return response;
    } catch (e) {
      return _onCatch(e);
    } finally {
      dio.close(force: true);
    }
  }

  Future<Response> delete(String url,
      {Map<String, String>? headers, dynamic data}) async {
    var dio = Dio();
    try {
      var response = await dio
          .deleteUri(Uri.parse(ApiPath.host + url),
              data: data, options: Options(headers: headers))
          .timeout(const Duration(seconds: Constants.defaultTimeOutDuration),
              onTimeout: _onTimeOut)
          .onError((DioException error, stackTrace) {
        return Response(
            requestOptions: error.requestOptions,
            data: error.response?.data,
            statusMessage: error.message,
            headers: error.response?.headers,
            statusCode: error.response?.statusCode);
      });
      return response;
    } catch (e) {
      return _onCatch(e);
    } finally {
      dio.close(force: true);
    }
  }
}

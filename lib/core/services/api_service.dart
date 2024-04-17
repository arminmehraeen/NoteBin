import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:notebin/config/app_config.dart';
import 'package:notebin/core/services/base_client_service.dart';
import 'package:notebin/core/services/storage_service.dart';

class ApiService extends BaseClientService {

  final StorageService storageService ;
  ApiService({required this.storageService});

  Map<String, String> _addAccessToken(Map<String, String>? headers) {
    headers = headers ?? <String, String>{};
    String? token = storageService.loadToken() ;
    headers['Authorization'] = "Bearer ${token ?? ""}";
    return headers;
  }

  void _logRequest(Response response) {
    List<String> texts = [
      "${response.requestOptions.method} (${response.statusCode.toString()}) => ${response.requestOptions.path}\nSEND DATA => ${response.requestOptions.data ?? "NO DATA SEND TO SERVER"}",
      "DATA => ${response.data ?? "NO DATA RECEIVE FROM SERVER"}",
    ];
    if(AppConfig.isLogRequest) {
      Logger().i(texts.join("\n"));
    }
  }

  @override
  Future<Response> get(String url,{Map<String, String>? headers, bool isAuth = true}) async {
    if (isAuth) headers = _addAccessToken(headers);
    Response response = await super.get(url, headers: headers);
    _logRequest(response);
    return response;
  }

  @override
  Future<Response> post(String url, {Map<String, String>? headers, dynamic data, bool isAuth = true}) async {
    if (isAuth) headers = _addAccessToken(headers);
    Response response = await super.post(url, headers: headers, data: data);
    _logRequest(response);
    return response;
  }


  @override
  Future<Response> delete(String url, {Map<String, String>? headers, dynamic data, bool isAuth = true}) async {
    if (isAuth) headers = _addAccessToken(headers);
    Response response = await super.delete(url, headers: headers, data: data);
    _logRequest(response);

    return response;
  }


}
// import 'package:dio/dio.dart';
// import 'base_client_service.dart';
//
// class RestApiServices extends BaseClient {
//   final authLocalStorage = x.Get.find<AuthLocalStorageServices>();
//   final dialog = AppDialog();
//   final snackBar = AppSnackBar();
//
//   @override
//   Future<Response> get(String url,
//       {Map<String, String>? headers,
//       bool isAuth = true,
//       bool showDialog = true}) async {
//     if (showDialog) {
//       dialog.loading();
//     }
//     if (isAuth) headers = _addAccessToken(headers);
//     Response response = await super.get(url, headers: headers);
//     printRequest(response);
//     if (response.statusCode.isUNAUTHORIZED) {
//       await _refreshAccessToken();
//       headers = _addAccessToken(headers);
//       response = await super.get(url, headers: headers);
//     }
//
//     if ((x.Get.isDialogOpen ?? false) && showDialog) x.Get.back();
//     if (response.statusCode.isFORBIDDEN) BaseController().noAccess();
//
//     return response;
//   }
//
//   @override
//   Future<Response> post(String url,
//       {Map<String, String>? headers, dynamic data, bool isAuth = true}) async {
//     dialog.loading();
//     if (isAuth) headers = _addAccessToken(headers);
//     Response response = await super.post(url, headers: headers, data: data);
//     printRequest(response);
//     if (response.statusCode.isUNAUTHORIZED) {
//       await _refreshAccessToken();
//       headers = _addAccessToken(headers);
//       response = await super.get(url, headers: headers);
//     }
//     if (x.Get.isDialogOpen ?? false) x.Get.back();
//     if (response.statusCode.isFORBIDDEN) {
//       snackBar.error("You do not have permission to perform this activity");
//     }
//
//     return response;
//   }
//
//   @override
//   Future<Response> postFormData(String url,
//       {Map<String, String>? headers, dynamic data, bool isAuth = true}) async {
//     dialog.loading();
//     if (isAuth) headers = _addAccessToken(headers);
//     Response response =
//         await super.postFormData(url, headers: headers, data: data);
//     printRequest(response);
//     if (response.statusCode.isUNAUTHORIZED) {
//       await _refreshAccessToken();
//       headers = _addAccessToken(headers);
//       response = await super.get(url, headers: headers);
//     }
//     if (x.Get.isDialogOpen ?? false) x.Get.back();
//     if (response.statusCode.isFORBIDDEN) {
//       snackBar.error("You do not have permission to perform this activity");
//     }
//
//     return response;
//   }
//
//   @override
//   Future<Response> patchFormData(String url,
//       {Map<String, String>? headers, dynamic data, bool isAuth = true}) async {
//     dialog.loading();
//     if (isAuth) headers = _addAccessToken(headers);
//     Response response =
//         await super.patchFormData(url, headers: headers, data: data);
//     printRequest(response);
//     if (response.statusCode.isUNAUTHORIZED) {
//       await _refreshAccessToken();
//       headers = _addAccessToken(headers);
//       response = await super.get(url, headers: headers);
//     }
//     if (x.Get.isDialogOpen ?? false) x.Get.back();
//     if (response.statusCode.isFORBIDDEN) {
//       snackBar.error("You do not have permission to perform this activity");
//     }
//
//     return response;
//   }
//
//   @override
//   Future<Response> put(String url,
//       {Map<String, String>? headers, dynamic data, bool isAuth = true}) async {
//     dialog.loading();
//     if (isAuth) headers = _addAccessToken(headers);
//     Response response = await super.put(url, headers: headers, data: data);
//     printRequest(response);
//     if (response.statusCode.isUNAUTHORIZED) {
//       await _refreshAccessToken();
//       headers = _addAccessToken(headers);
//       response = await super.get(url, headers: headers);
//     }
//     if (x.Get.isDialogOpen ?? false) x.Get.back();
//     if (response.statusCode.isFORBIDDEN) {
//       snackBar.error("You do not have permission to perform this activity");
//     }
//
//     return response;
//   }
//
//   @override
//   Future<Response> patch(String url,
//       {Map<String, String>? headers, dynamic data, bool isAuth = true}) async {
//     dialog.loading();
//     if (isAuth) headers = _addAccessToken(headers);
//     Response response = await super.patch(url, headers: headers, data: data);
//     printRequest(response);
//     if (response.statusCode.isUNAUTHORIZED) {
//       await _refreshAccessToken();
//       headers = _addAccessToken(headers);
//       response = await super.get(url, headers: headers);
//     }
//     if (x.Get.isDialogOpen ?? false) x.Get.back();
//     if (response.statusCode.isFORBIDDEN) {
//       snackBar.error("You do not have permission to perform this activity");
//     }
//
//     return response;
//   }
//
//   @override
//   Future<Response> delete(String url,
//       {Map<String, String>? headers, dynamic data, bool isAuth = true , bool showDialog = true}) async {
//     if(showDialog) {
//       dialog.loading();
//     }
//     if (isAuth) headers = _addAccessToken(headers);
//     Response response = await super.delete(url, headers: headers, data: data);
//     printRequest(response);
//     if (response.statusCode.isUNAUTHORIZED) {
//       await _refreshAccessToken();
//       headers = _addAccessToken(headers);
//       response = await super.get(url, headers: headers);
//     }
//     if (x.Get.isDialogOpen ?? false) x.Get.back();
//     if (response.statusCode.isFORBIDDEN) {
//       snackBar.error("You do not have permission to perform this activity");
//     }
//
//     return response;
//   }
//
//   printRequest(Response response) {
//     List<String> texts = [
//       "${response.requestOptions.method} (${response.statusCode.toString()}) => ${response.requestOptions.path}\nSEND DATA => ${response.requestOptions.data ?? "NO DATA SEND TO SERVER"}",
//       "DATA => ${response.data ?? "NO DATA RECEIVE FROM SERVER"}",
//     ];
//     if(AppConfig.debug) {
//       logger.i(texts.join("\n"));
//     }
//   }
//
//   Map<String, String> _addAccessToken(Map<String, String>? headers) {
//     headers = headers ?? <String, String>{};
//     String? token = (authLocalStorage.getTokens())?.accessToken;
//     headers['Authorization'] = "Bearer ${token ?? ""}";
//     return headers;
//   }
//
//   Future<void> _refreshAccessToken() async {
//     String? token = (authLocalStorage.getTokens())?.refreshToken;
//     Response response =
//         await super.post(ApiPath.refreshAccessToken, data: {"refresh": token});
//     printRequest(response);
//     if (response.statusCode.isOK) {
//       authLocalStorage.saveTokens(Tokens(response.data['access'], token!));
//     } else {
//       BaseController().logout();
//     }
//   }
// }

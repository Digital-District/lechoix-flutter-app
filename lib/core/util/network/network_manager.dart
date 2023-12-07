// import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:lechoix/cache/user_cache.dart';
import 'package:lechoix/data/Enumeration.dart';
import 'package:lechoix/data/base/BaseResponse.dart';
import 'package:lechoix/main.dart';
import 'endpoints.dart';
import 'parser.dart';

class NetworkManager {
  // static Alice alice = Alice(
  //     navigatorKey: NavigationUtil.navigatorKey,
  //     showNotification: true,
  //     showInspectorOnShake: true,
  //     darkTheme: false);

  late Dio dio;
  CancelToken? cancelToken;
  UserCache userCache = UserCache.instance;

  Map<String, dynamic> headers = {
    "Accept": "application/json",
    "locale": UserCache.instance.getLanguage(),
    "device-token": UserCache.instance.getDeviceId(),
  };

  NetworkManager({this.cancelToken}) {
    dio = Dio();
    if (UserCache.instance.isLoggedIn()) {
      headers["Authorization"] =
          "Bearer ${UserCache.instance.getAccessToken()}";
    }
    var baseURL =  Endpoints.baseUrl;
    if (isProductionMood == false){
      baseURL = Endpoints.stagingBaseUrl;
    }
    dio.options = BaseOptions(headers: headers, baseUrl: baseURL);
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      request: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ));
    // if (isProductionMood == false){
    //   dio.interceptors.add(alice.getDioInterceptor());
    // }
  }

  Future<BaseResponse<T>> request<T>(String url, Method method,
      {Map<String, dynamic>? data}) async {
    Response? response;
    data ??= {};
    if (method == Method.GET) {
      response = await dio.get(url, queryParameters: data);
    } else if (method == Method.POST) {
      response = await dio.post(url, data: data);
    } else if (method == Method.PATCH) {
      response = await dio.patch(url, data: data);
    } else if (method == Method.DELETE) {
      response = await dio.delete(url);
    } else if (method == Method.postFormData) {
      response = await dio.post(url, data: FormData.fromMap(data));
    }
    return parseResponse<T>(response);
  }

  BaseResponse<T> parseResponse<T>(Response? response) {
    BaseResponse<T> baseResponse = BaseResponse();

    if (response == null || response.data == null) return baseResponse;

    baseResponse.message = response.data["message"];
    if (T == dynamic) {
      baseResponse.data = null;
    } else {
      baseResponse.data = Parser.parse<T>(response.data["data"]);
    }

    return baseResponse;
  }
}

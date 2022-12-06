import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';

import 'NavigationService.dart';

class DioService {
  static Dio _dio;
  static PersistCookieJar cookieJar;
  static const url = 'http://192.168.1.15:3000/';

  static Future initService() async {
    _dio = new Dio();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    cookieJar = PersistCookieJar(dir: appDocPath + "/.cookies/");
    _dio.interceptors.add(CookieManager(cookieJar));
    _dio.interceptors.add(CustomInterceptor());
  }

  static Dio get dio {
    return _dio;
  }
}

class CustomInterceptor extends Interceptor {
  /*@override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }
  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) {
    print('RESPONSE[${response.statusCode}] => PATH: ${response.request?.path}');
    return super.onResponse(response, handler);
  }*/
  @override
  Future<dynamic> onError(error) async {
    if (error.message.contains("403"))
      NavigationService.instance.goToAuthScreen();
    return error;
    //Navigator.of(context)
    //print('ERROR[${err.response?.statusCode}] => PATH: ${err.request.path}');
    //return super.onError(err, handler);
  }
}

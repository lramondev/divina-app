import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:localstorage/localstorage.dart';

import 'package:divina/network/endpoints.dart';

import 'package:divina/shared/models/user_model.dart';

class Intercept extends Interceptor {

  final LocalStorage storage = LocalStorage('app');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String? userData = storage.getItem('user');
    User? user = userData != null ? User.fromJson(jsonDecode(userData)) : null;
    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';
    options.headers['Authorization'] = 'Bearer ${user?.token}';
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if(err.response?.statusCode == 401) {
      Modular.to.popAndPushNamed('/login/');
    }
    handler.next(err);
  }
}

class DioClient {
  final Dio _dio;
  
  DioClient(this._dio) {
    print('dioClient');
    _dio..options.baseUrl = Endpoints.apiUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..interceptors.add(Intercept())
      ..interceptors.add(LogInterceptor(
        request: false,
        requestHeader: false,
        requestBody: false,
        responseHeader: false,
        responseBody: false,
      ));
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = ((client) {
      final SecurityContext context = SecurityContext();
      
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      context.setTrustedCertificatesBytes(Endpoints.cert);
      return HttpClient(context: context);
    }); 
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    final Response response = await _dio.get(
      url,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
    return response;
  }

  Future<Response> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final Response response = await _dio.post(
      uri,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return response;
  }

  Future<Response> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final Response response = await _dio.put(
      uri,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return response;
  }

  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final Response response = await _dio.delete(
      uri,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data;
  }
}
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import '../Constrants.dart';
import '../http/dio_util.dart';

class ApiService {
  Dio _dio = DioUtil.getInstance()!.dio;

  void refreshHeaders() {
    /*BaseOptions options = BaseOptions(
      //baseUrl: BASE_URL,
        connectTimeout: DioUtil.CONNECT_TIMEOUT,
        receiveTimeout: DioUtil.RECEIVE_TIMEOUT,
        method: 'get');
    Singleton().accessToken = SpUtil.getString('accessToken', defValue: '');
    options.headers["x-api-key"] = "GCMUDiuY5a7WvyUNt9n3QztToSHzKWZB";
    options.headers['authorization'] = 'Bearer ${Singleton().accessToken}';
    Cfg.applyClient();*/

    /// 初始化dio
    // _dio.options = options;
  }

  Future<Response> goAuth(String code, String state) async {
    final resp = await _dio.get(
      "${Constrants.API_AUTH}&code=$code&state=$state",
    );
    return resp;
  }
}
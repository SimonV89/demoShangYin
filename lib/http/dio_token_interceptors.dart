import 'package:dio/dio.dart';


class DioTokenInterceptors extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // 响应前需要做刷新token的操作
    if (response.statusCode == 10001 || response.statusCode == 10003) {
      /*String? accessToken = SpUtil.getString('accessToken', defValue: '');
      String? refreshToken = SpUtil.getString('refreshToken', defValue: '');
      if (accessToken != '' && refreshToken != '') {
        DioUtil.getInstance()?.dio.lock();
        Dio _tokenDio = DioUtil.getInstance()!.dio;
        _tokenDio.options = {"authorization": accessToken} as BaseOptions;
        _tokenDio.post(DioUtil.BASE_URL+"/v1/token/refresh",
            data: {'refreshToken': refreshToken}).then((d) {
          showToast("请重新登录（Server端登录态失效）");
        }).catchError((error, stackTrace) {
          handler.reject(error, true);
        }).whenComplete(() {
          DioUtil.getInstance()?.dio.unlock();
          SpUtil.putString('accessToken', '');
          SpUtil.putString('refreshToken', '');
          SpUtil.putObject('user', {});
          eventBus.fire(LoginStatusEvent(false));
          jump();
        });
      } else {*/
        //jump();
    } else {
      super.onResponse(response, handler);
    }
  }

  /*final NavigationService navService = NavigationService();

  jump() {
    *//*,args:'From Home Screen'*//*
    navService.pushNamed('/login');
  }*/

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}

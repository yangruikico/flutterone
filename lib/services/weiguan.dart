
import 'dart:io';

import 'package:dio/dio.dart';

class WgApiResponse {
  static const int codeResponseError = -2;
  static const int codeRequestError = -1;
  static const int codeOk = 0;

  int code;
  String message;
  Map<String, dynamic> data;

  WgApiResponse({this.code = codeOk, this.message = "", this.data});

  static WgApiResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    WgApiResponse imageBean = WgApiResponse();
    imageBean.code = map['code'];
    imageBean.message = map['message'];
    imageBean.data = map['data'];

    return imageBean;
  }

  Map toJson() => {
        "code": code,
        "message": message,
        "data": data,
      };
}

class WgService {
  final _client = Dio();

  WgService() {
    _client.options.baseUrl = "http://baidu.com";
  }

  Future<WgApiResponse> request(String method, String path,
      {dynamic data}) async {
    _client.options.method = method;

    var response = Response();
    try {
      response = await _client.request(path,
          data: data, options: Options(method: _client.options.method));
    } catch (e) {
      return WgApiResponse(
          code: WgApiResponse.codeRequestError, message: 'message');
    }

    if (response.statusCode == HttpStatus.ok) {
      return WgApiResponse.fromMap(
          response.data); // WgApiResponse.fromJson(response.data)
    } else {
      return WgApiResponse(
          code: WgApiResponse.codeResponseError,
          message: response.statusCode.toString());
    }
  }

  Future<WgApiResponse> get(String path, {Map<String, dynamic> data}) async {
    return request('GET', path, data: data);
  }

  Future<WgApiResponse> post(String path, {Map<String, dynamic> data}) async {
    return request('POST', path, data: data);
  }

  Future<WgApiResponse> postForm(String path, {FormData data}) async {
    return request('POST', path, data: data);
  }
}

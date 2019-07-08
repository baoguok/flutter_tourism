import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
//import 'package:json_annotation/json_annotation.dart';


class HttpGo {
  static final String GET = 'get';
  static final String POST = 'post';
  static final String DATA = 'data';
  static final String CODE = 'errorCode';

  Dio dio;
  static HttpGo _instance;
  static HttpGo getInstance(){
    if(_instance==null){
      _instance = HttpGo();
    }
    return _instance;
  }

  HttpGo() {
    var options = new BaseOptions(
      baseUrl: 'http://test.ming.32ui.cn/ming',
      connectTimeout: 10000,
      receiveTimeout: 10000,
      headers: {
//        "Authorization": '66CB513D75FF4B3869A576594E8398F2C02FCFFF4C1F024A9B9A8F8D713F4991'
      },
      contentType: ContentType.json,
      responseType: ResponseType.json
    );

    dio = Dio(options);
  }


//  get请求
  get(String url,[params]) async {
    return await _requstHttp(url, GET, params);
  }

//  post请求
  post(String url, [params]) async {
    return await _requstHttp(url, POST, params);
  }

//  带token的get请求
  getWithToken(String url,token,[params]) async {
    await _addStartHttpInterceptor(dio, token); //添加请求之前的拦截器
    return await _requstHttp(url, GET, params);
  }

//  带token的post请求
  postWithToken(String url, token, [params]) async {
    await _addStartHttpInterceptor(dio, token); //添加请求之前的拦截器
    return await _requstHttp(url, POST, params);
  }

//    请求方法
  _requstHttp(String url,[String method, params]) async {
    String errorMsg = '';
    int code;

    try {
      Response response;
      if (method == GET) {
        if (params != null && params.isNotEmpty) {
          response = await dio.get(url, queryParameters: params);
        } else {
          response = await dio.get(url);
        }
      } else if (method == POST) {
        if (params != null && params.isNotEmpty) {
          response = await dio.post(url, queryParameters: params);
        } else {
          response = await dio.post(url);
        }
      }

      code = response.statusCode;
      if (code != 200) {
        errorMsg = '错误码：' + code.toString() + '，' + response.data.toString();
      }
//      String dataStr = JsonSerializable.fromJson(response.data);
//      Map<String, dynamic> dataMap = json.decode(dataStr);
//      if (dataMap != null && !dataMap['success']) {
//        errorMsg = dataMap['msg'].toString();
//      }
      if(!response.data['success']){
        Fluttertoast.showToast(
          msg: response.data['msg'],
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          backgroundColor: Colors.red
        );
      }
      return response;
    } catch (exception) {
      _error(exception.toString());
    }
  }

  _error(String error) {
    Fluttertoast.showToast(
      msg: error.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER);
  }

  _addStartHttpInterceptor(Dio dio, token) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options){
        options.headers['Authorization'] = token;
        return options;
      }
    ));
  }

}
//66CB513D75FF4B3869A576594E8398F2C02FCFFF4C1F024A9B9A8F8D713F4991
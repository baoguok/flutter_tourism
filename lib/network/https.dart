import 'package:dio/dio.dart';
import 'dart:io';

class Instance extends Dio {

  static const CONTENT_TYPE_JSON = "application";
  static const CONTENT_TYPE_FORM = "x-www-form-urlencoded";
  static const CONTENT_CHAT_SET = 'utf-8';

  factory Instance() => _getInstance();
  static Instance get instance => _getInstance();
  static Instance _instance;

//    初始化
  Instance._init(){

  }

  static Instance _getInstance(){
    if(_instance == null){
      _instance = Instance._init();
      BaseOptions options = BaseOptions(
        connectTimeout: 15000,
        receiveTimeout: 15000,
        contentType: ContentType(
          CONTENT_TYPE_JSON, CONTENT_TYPE_FORM,
          charset: CONTENT_CHAT_SET
        )
      );
      _instance.options = options;
    }
    return _instance;
  }
}



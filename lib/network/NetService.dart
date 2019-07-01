library msnetservice;

export 'ResultData.dart';


import 'package:dio/dio.dart';
import 'dart:convert';
import 'ResultData.dart';
import 'https.dart';


enum Method {
  GET,POST,UPLOAD,DOWNLOAD
}


class NetService {
  get(String url, {Object params}) async {
    return await request(url, method: Method.GET, params: params);
  }




  request(String url, {Method method, Object params, var file, String fileName,
    String fileSavePath}) async {
    try{
      Response response;
      Instance newinstance = Instance();
      var headers = await getHeaders();
      if(headers != null){
        newinstance.options.headers = headers;
      }
      var baseUrl = await getBasicUrl();
      newinstance.options.baseUrl = baseUrl;

      switch (method) {
        case Method.GET:
          response = await newinstance.get(url, queryParameters: params);
          break;
        case Method.POST:
          response = await newinstance.post(url, data: params);
          break;
        case Method.UPLOAD:
          {
            FormData formData = new FormData();
            if(params!=null){
              formData = FormData.from(params);
            }
            formData.add('files', UploadFileInfo.fromBytes(file, fileName+'.png'));
            response = await newinstance.post(url, data: formData);
            break;
          }
        case Method.DOWNLOAD:
          response = await newinstance.download(url, fileSavePath);
          break;
      }
      return handleDataSource(response, method);
    }catch(expection){
      return ResultData(expection.toString(), false);
    }
  }
}

handleDataSource(Response response, Method method){
  String errorMsg = '';
  int statusCode;
  statusCode = response.statusCode;
  if(method == Method.DOWNLOAD){
    if(statusCode == 200){
      return ResultData('下载成功！', true);
    }else {
      return ResultData('下载失败', false);
    }
  }

//  错误处理
  if(statusCode < 0 ){
    errorMsg = '网络错误，错误码：'+ statusCode.toString();
    return ResultData(errorMsg, false);
  }

  try{
    Map data = jsonDecode(response.data);
    if(data['success']){
      try{
        return ResultData(data['data'], true);
      }catch(expection){
        return ResultData('暂无数据', false);
      }
    }
  }catch(error){
    List data = jsonDecode(response.data);
    return ResultData(data, true);
  }
}

getHeaders(){
  return null;
}

getBasicUrl(){
  return null;
}
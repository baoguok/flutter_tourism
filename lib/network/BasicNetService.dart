library basicNetService;

export 'NetService.dart';
import 'NetService.dart';


class BasicNetService extends NetService {
  String url;
  Method method;

  @override
  request(String url, {Method method, Object params, file, String fileName, String fileSavePath}) {
    // TODO: implement request
    this.url = url;
    this.method = method;
    Map newParams = {};
    return super.request(url, method: method, params: newParams, file: file, fileName: fileName, fileSavePath: fileSavePath);
  }

  @override
  getBasicUrl(){
    String basicUrl;
    basicUrl = 'http://test.ming.32ui.cn/ming';
    return basicUrl;
  }

  @override
  getHeaders(){
    Map<String, dynamic> headers;
    switch(this.url){
      //判断url，添加请求头Authorization

    }
    return headers;
  }
}
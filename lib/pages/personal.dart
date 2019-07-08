import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/right_pannel.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_app/model/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_app/network/request.dart';


class Personal extends StatefulWidget {
  @override
  _Personal createState() => new _Personal();
}

class _Personal extends State<Personal> {
  String token;
  String phone;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

//  Future getUserInfo() async {
//    SharedPreferences preferences = await SharedPreferences.getInstance();
//    String account = preferences.get('account');
//    print('读取到acount为:$account');
//  }

  getUserinfo(token) async{
    var data = await HttpGo().getWithToken('/api/user/info.json',token);
//    print(data);
    setState(() {
      phone = data.data['data']['mobile'];
    });
  }

  @override
  Widget build(BuildContext context) {
//    this.getUserInfo();
    //获取scoped_model状态
    final userInfo = ScopedModel.of<Models>(context, rebuildOnChange: true).userInfo;
    final tokens = jsonDecode(jsonEncode(userInfo))['token'];
    if(tokens != null){
      setState(() {
        token = tokens;
      });
      if(phone == null){
        this.getUserinfo(tokens);
      }
    }


    //路由参数接收
//    final id = ModalRoute.of(context).settings.arguments;
//    print(id);
    // TODO: implement build
    Widget onpress(index){
      if(index == 0){
        Navigator.pop(context);
      }else if(index == 1){
        Navigator.pushNamed(context, 'buyer',arguments: {'id': index});
      }
    }
    return ScopedModelDescendant<Models>(
      builder: (context, child, model){
        return Scaffold(
            body: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 214,
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: <Widget>[
                        Positioned(child: Image.asset('images/beijing@3x.png', fit: BoxFit.fitWidth,)),
                        Positioned(child: Image.asset('images/Bitmap@3x.png', fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width*0.8,
                        ),bottom: 0,),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: 75,
                            width: MediaQuery.of(context).size.width*0.8,
                            child: Column(
                              children: <Widget>[
                                Logined(),
                                SizedBox(height: 5,),
                                Text('"畅游长城，体验世界级奇观！"')
                              ],
                            ),
                          ),
                        ),
                        Positioned(child: Image.asset('images/touxiang@3x.png', fit: BoxFit.fitWidth,width: 60,),
                          top: 60,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: Row(children: <Widget>[
                      Column(children: <Widget>[
                        Image.asset('images/zhifu@3x.png', height: 32, fit: BoxFit.fitHeight,),
                        SizedBox(height: 5,),
                        Text('待支付',style: TextStyle(fontSize: 12),)
                      ],),
                      Column(children: <Widget>[
                        Image.asset('images/yizhifu@3x.png', height: 32, fit: BoxFit.fitHeight),
                        SizedBox(height: 5,),
                        Text('已支付',style: TextStyle(fontSize: 12),)
                      ],),
                      Column(children: <Widget>[
                        Image.asset('images/yishiyong@3x.png', height: 32, fit: BoxFit.fitHeight),
                        SizedBox(height: 5,),
                        Text('已取票',style: TextStyle(fontSize: 12),)
                      ],),
                      Column(children: <Widget>[
                        Image.asset('images/yiquxiao@3x.png', height: 32, fit: BoxFit.fitHeight),
                        SizedBox(height: 5,),
                        Text('已取消',style: TextStyle(fontSize: 12),)
                      ],),
                    ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Pannel(name: '取票人管理', url: 'images/renyuanguanli@3x.png',),
                  Pannel(name: '关于我们', url: 'images/guanyuwomen-@3x.png',),
                  SizedBox(height: 5,),
                  Pannel(name: '账户设置', url: 'images/shezhi@3x.png',),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页'),),
              BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart), title: Text('购买')),
              BottomNavigationBarItem(icon: Icon(Icons.perm_identity), title: Text('个人中心')),
            ],
              selectedFontSize: 12,
              currentIndex: 2,
              selectedItemColor: Color(0xff1EBDA8),
              iconSize: 24,
              onTap: (index){
                onpress(index);
              },
            )
        );
      },
    );
  }


//  根据是否登录生成Widget
  Widget Logined(){
    if(this.token !=null){     //已登录
      return Container(
        child: Center(child: Text(this.phone??''),),
        height: 38,
      );
    }else{      //未登录
      return GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, 'login');
        },
        child: Container(
          child: Center(child: Text('登录/注册',style: TextStyle(color: Colors.white, fontSize: 16),)),
          width: 116,
          height: 38,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(19)),
            color: Color(0xff1EBDA8),
          ),
        ),
      );
    }
  }

}
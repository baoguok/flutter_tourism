import 'package:flutter/material.dart';
import 'package:flutter_app/network/request.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _Home createState()=> new _Home();
}


class _Home extends State<Home> {
  int _tabIndex = 0;
  var banners;


  @override
  Widget build(BuildContext context) {
    //路由传参
//    final id = ModalRoute.of(context).settings.arguments;
    _bannerData().then((res)=>{
      banners = res.data['data']
    });      //banner数据


    // TODO: implement build
    Widget onpress(index){
      if(index != _tabIndex){
        if(index == 2){
          Navigator.pushNamed(context, 'personal',arguments: {'id': index});
        }else if(index == 1){
          Navigator.pushNamed(context, 'buyer', arguments: {'id': index});
        }
      }
    }
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        backgroundColor: Color(0xff1EBDA8),
        title: Text('居庸关景区'),
        actions: <Widget>[
//          IconButton(icon: Icon(Icons.access_alarms), highlightColor: Color(0xffffffff), onPressed: null),
          PopupMenuButton(
            itemBuilder: (BuildContext) => [
              PopupMenuItem(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.message),
                    Text('发起群聊')
                  ],
                ),
              ),
              PopupMenuItem(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.group_add),
                    Text('添加服务')
                  ],
                ),
              ),
              PopupMenuItem(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.cast_connected),
                    Text('扫一扫')
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Image.network(banners[0]['coverUrl'])
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页'),),
          BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart), title: Text('购买')),
          BottomNavigationBarItem(icon: Icon(Icons.perm_identity), title: Text('个人中心')),
        ],
        currentIndex: _tabIndex,
        selectedItemColor: Color(0xff1EBDA8),
        iconSize: 24,
        selectedFontSize: 12,
        onTap: (index) {
          onpress(index);
        },
      ),
    );
  }

  _bannerData() async {
    return await HttpGo().get('/api/banner.json');
  }
}

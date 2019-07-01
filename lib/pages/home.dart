import 'package:flutter/material.dart';
import 'package:flutter_app/network/request.dart';
import 'dart:convert';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Home extends StatefulWidget {
  @override
  _Home createState()=> new _Home();
}


class _Home extends State<Home> {
  int _tabIndex = 0;
  var banners = [], baseInfo = {},location={}, news={};


  @override
  Widget build(BuildContext context) {
    //路由传参
//    final id = ModalRoute.of(context).settings.arguments;
    _bannerData().then((res)=>{
      banners = res.data['data']
    });      //banner数据

    _tourismInfo().then((res) =>{     //景区信息
      baseInfo = res.data['data']
    });

    getLocation().then((res)=>{
      location = res
    });

    _getNews().then((res)=>{
      news = res.data['data']
    });

    Widget News(){
      print(news['list'].length);
      if(news['list'].length>=0){
        for(var i=0;i<news['list'].length;i++){
          return Row(
            children: <Widget>[
              Image.asset('${news['list'][i]['coverUrl']}',fit: BoxFit.fitWidth,width: 118,),
              SizedBox(width: 10,),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('${news['list'][i]['title']}',style: TextStyle(fontSize: 16),),
                  Text('${news['list'][i]['subject']}',style: TextStyle(color: Colors.grey,fontSize: 13),),
                  Text('${news['list'][i]['createTime']}',style: TextStyle(color: Colors.grey,fontSize: 12))
                ],))
            ],
          );
        }
      }else {
        return Expanded(child: Container(),);
      }
    }
    
    // TODO: implement build
    Widget onpress(index){
      print(news['list']);
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
//            Image.network(banners[0]['coverUrl'])
            Container(
              width: MediaQuery.of(context).size.width,
              height: 165,
              child: Swiper(
                itemCount: banners.length,
                autoplay: true,
                scrollDirection: Axis.horizontal,
//                pagination: new SwiperPagination(),
//                control: new SwiperControl(),
                itemBuilder: (BuildContext, index){
//                  if(banners.length >= 0){
                    return (Image.network(banners[index]['coverUrl'],fit: BoxFit.fill,));
//                  }
                },
                duration: 500
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Row(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(children: <Widget>[
                          Text('${baseInfo['name']}', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          SizedBox(width: 5),
                          Text('${baseInfo['type']}',style: TextStyle(fontSize: 13),),
                          SizedBox(width: 5,),
                          Text('${location['tempture']['data']['weather']}',style: TextStyle(fontSize: 13)),
                          SizedBox(width: 5,),
                          Text('${location['tempture']['data']['temperature']}',style: TextStyle(fontSize: 13)),
                          SizedBox(width: 5,),
                          Text('${location['tempture']['data']['wind']}',style: TextStyle(fontSize: 13,)),
                        ]),
                        SizedBox(height: 5,),
                        Row(
                          children: <Widget>[
                            Image.asset('images/dizhi@3x.png', fit: BoxFit.contain,height: 16,),
                            SizedBox(width: 5,),
                            Text('${location['region']['data']['province']}${location['region']['data']['city']}',style: TextStyle(color: Colors.grey),)
                          ],
                        )
                      ],
                    )),
                    GestureDetector(
                      child: Icon(Icons.phone, size: 30,color: Color(0xff1EBDA8),),
                      onTap: (){
                        print(baseInfo['telephone']);
                        launch('tel:${baseInfo["telephone"]}');
                      },
                    )
                  ]),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex:1,
                        child: Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Color(0xffF5FFFE)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text('景区须知'),
                                  Text('景区时间，入园须知',style: TextStyle(fontSize: 12,color: Colors.grey))
                                ],
                              ),
                              Image.asset('images/xiayibu@3x.png', width: 10,),
//                              SizedBox(width: 10,)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              color: Color(0xffF5FFFE)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text('景区须知'),
                                  Text('景区时间，入园须知',style: TextStyle(fontSize: 12,color: Colors.grey),)
                                ],
                              ),
                              Image.asset('images/xiayibu@3x.png', width: 10,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 15,),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Color(0xffeeeeee),width: 1))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('景区资讯',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      Row(children: <Widget>[
                        Text('更多',style: TextStyle(color: Colors.grey),),
                        Image.asset('images/xiayibu@3x.png', width: 7,)
                      ],)
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(15),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      News(),
                      Row(
                        children: <Widget>[
                          Image.asset('images/avatar.jpg',fit: BoxFit.fitWidth,width: 118,),
                          SizedBox(width: 10,),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                            Text('五一黄金周',style: TextStyle(fontSize: 16),),
                            Text('按实际欧克怕热胡一平',style: TextStyle(color: Colors.grey,fontSize: 13),),
                            Text('2019-05-01',style: TextStyle(color: Colors.grey,fontSize: 12))
                          ],))
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )

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


  _bannerData() async {     //banner图数据
    return await HttpGo().get('/api/banner.json');
  }

  _tourismInfo() async {     //基本信息数据
    return await HttpGo().get('/api/settings.json');
  }
  
  getLocation() async {     //位置和天气
    var region = await HttpGo().get('/api/settings/region.json');
//    print(region.data['data']['city']);
    var tempture = await HttpGo().get('/api/settings/weater.json?city=${region.data['data']['city']}');
//    print(tempture);
    return {
      'region': region.data,
      'tempture': tempture.data
    };
  }

  _getNews() async {
    return await HttpGo().get('/api/news.json?pageIndex=1&pageSize=10');
  }

}

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_app/widgets/ticker_unit.dart';
import 'package:flutter_app/widgets/date_picker.dart';

import 'package:flutter_app/network/request.dart';


class Order extends StatefulWidget{

  @override
  _Order createState()=> new _Order();
}


class _Order extends State<Order> {
  String id='';               //订单id
  var obj = {};            //订单信息
  Map currentDate = {};    //当前选中的日期对象
  List priceList = [];      //所有的日期
  List showDate = [{},{},{}];       //渲染的三个日期
  bool opacity = false;


  getorderInfo(id) async{
    if(id.isNotEmpty){
      var res = await HttpGo().get('/api/ticket/info/${id}.json');
      var data = res.data['data'];
      var prices = res.data['data']['prices'];
      setState(() {
        obj = data;
      });
      var lists = [];
      prices.forEach((key,value){
        lists.add({'date': key, 'price': value});
      });
//      print(lists);
      setState(() {
        priceList = lists;
        currentDate = lists[0];
        showDate = lists.sublist(0,3);
      });
    }
  }

  getPannel(item){
    return item.isNotEmpty?GestureDetector(
      child: Stack(
        children: <Widget>[
          Container(
          width: MediaQuery.of(context).size.width*0.23,
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          decoration: BoxDecoration(
            color: Colors.white,
            border: (currentDate.isNotEmpty&& currentDate['date']==item['date'])?
            Border.all(color: Color(0xff1EBDA8)):Border.all(color: Color(0xffeeeeee)),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          child: Column(
            children: <Widget>[
              showDate.isNotEmpty?Text('${item['date']}'):SizedBox(width: 1,),
              SizedBox(height: 4,),
              showDate.isNotEmpty?Text('${item['price']}'):SizedBox(width: 1,),
            ],
          )),
          (currentDate.isNotEmpty&& currentDate['date']==item['date'])?Positioned(
            child: Image.asset('images/xuanzhong@3x.png',width: 20,fit: BoxFit.fitWidth,),
            right: 0,
            bottom: 0,
          ):Text('')
        ],
      ),onTap: (){
        setState(() {
          currentDate = item;
        });
      },
    ):Text('');
  }


  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context).settings.arguments;
    setState(() {
      id = jsonDecode(jsonEncode(args))['id'];
    });
    if(obj.isEmpty){
      getorderInfo(jsonDecode(jsonEncode(args))['id']);
    }
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('订单填写'),),
        backgroundColor: Color(0xff1EBDA8),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 5,),
                  Unit(obj: obj,address: false,price: currentDate.isNotEmpty?currentDate['price']: '42',),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    color: Colors.white,
                    child: Column(children: <Widget>[
                      Text('选择日期'),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
//                    (currentDate.isNotEmpty&& currentDate['date']==showDate[0]['price'])?
                          getPannel(showDate[0]),
                          getPannel(showDate[1]),
                          getPannel(showDate[2]),
                          GestureDetector(
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.2,
                              padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Color(0xffeeeeee)),
                                borderRadius: BorderRadius.all(Radius.circular(6)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text('更多日期'),
                                  Icon(Icons.chevron_right ,size: 20,)
                                ],
                              ),

                            ),onTap: (){
                              setState(() {
                                opacity = !opacity;
                              });
                            },
                          )
                        ],
                      ),

                    ],crossAxisAlignment: CrossAxisAlignment.start,),
                  ),
                ],
              ),
            ),
//            DatePicker()
//            Positioned(
////              bottom: date_position,
//              child: DatePicker(
//                onSelect: (date) =>{selectDatePicker(date)},
//              )
//            )
          ],
        ),
      ),
    );
  }

  selectDatePicker(date){
    print(date);
    setState(() {
//      date_position = 0;
    });
  }
}
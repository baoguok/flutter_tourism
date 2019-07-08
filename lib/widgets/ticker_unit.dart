import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';



class Unit extends StatelessWidget {

  final obj;
  final address;
  final price;
  final token;
  Timer _timer = null;

  Unit({@required this.obj, @required this.address, this.price,this.token});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xffeeeeee),width: 1,style: BorderStyle.solid)),
        color: Colors.white
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${obj['title']}',style: TextStyle(fontSize: 18),),
              SizedBox(height: 5,),
              Row(children: <Widget>[
                Image.asset('images/tixing@3x.png',width: 10,),
                SizedBox(width: 5,),
                Text('${obj['buyOverInfo']}',style: TextStyle(fontSize: 12,color: Colors.grey),)
              ],),
              SizedBox(height: 5,),
              Row(children: <Widget>[
                Image.asset('images/ziyuan@3x.png',width: 10,),
                SizedBox(width: 5,),
                Text('${obj['activeInfo']}',style: TextStyle(fontSize: 12,color: Colors.grey),)
              ],),
              SizedBox(height: 5,),
              Row(children: <Widget>[
                Text('订票须知',style: TextStyle(fontSize: 13),),
                Icon(Icons.navigate_next,size: 20,)
              ],),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('￥',style: TextStyle(color: Color(0xffFF5A00)),),
                  Text('${obj['price']!=null?obj['price']:price}',style: TextStyle(color: Color(0xffFF5A00),fontSize: 20),),
                  Text('起',style: TextStyle(fontSize: 12),),
                ],
              ),
              address?RaisedButton(onPressed: (){
                if(token !=null){
                  Navigator.pushNamed(context, 'order',arguments: {
                    'id': obj['id']
                  });
                }else{
                  Fluttertoast.showToast(msg: '请先登录！');
                  _timer = Timer.periodic(Duration(seconds: 1), (timer){
                    Navigator.pushNamed(context, 'login');
                    _timer.cancel();
                  });
                }
              },child: Text('预定',style: TextStyle(color: Colors.white,fontSize: 15),),
              color: Color(0xff1EBDA8),padding: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
              )):SizedBox(width: 1,)
            ],
          )
        ],
      ),
    );
  }
}
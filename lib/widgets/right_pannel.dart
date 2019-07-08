import 'package:flutter/material.dart';

class Pannel extends StatelessWidget{

//  如果需要从别的组件传参数，必须以下写法
  final String name;
  final String url;
  Pannel({this.name, this.url});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(18),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(children: <Widget>[
            this.url.isNotEmpty?Image.asset(url,width: 18,fit: BoxFit.fitWidth,): SizedBox(height: 1,),
            this.url.isNotEmpty?SizedBox(width: 5,):SizedBox(height: 1,),
            Text(name)
          ],),
          Image.asset('images/xiayibu.png', width: 7,)
        ],
      ),
    );
  }
}
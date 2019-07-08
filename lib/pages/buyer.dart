import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/right_pannel.dart';
import 'package:flutter_app/widgets/ticker_unit.dart';

import 'package:flutter_app/network/request.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_app/model/models.dart';
import 'dart:convert';




class Buyer extends StatefulWidget {

  @override
  _Buyer createState() => new _Buyer();
}

class _Buyer extends State<Buyer> {
  int _tabIndex = 1;
  List hotLists = [];
  List adultLists = [];
  List studentLists = [];
  var token = null;
//  @override
//  void didUpdateWidget(Buyer oldWidget) {
//    // TODO: implement didUpdateWidget
//    super.didUpdateWidget(oldWidget);
//    this.getHotTicket(1);
//
//  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getHotTicket(1);
    this.getHotTicket(2);
    this.getHotTicket(3);
  }

  getHotTicket(i) async{
    var res = await HttpGo().get('/api/ticket/${i}.json');
    if(i==1){
      setState(() {
        hotLists = res.data['data'];
      });
    }
    if(i==2){
      setState(() {
        adultLists = res.data['data'];
      });
    }
    if(i==3){
      setState(() {
        studentLists = res.data['data'];
      });
    }
  }

  getLists(List lists){
    if(lists.isNotEmpty){
      return Container(
        color: Colors.white,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          physics:NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: lists.length,
          itemBuilder: (context, index){
            return Unit(obj: lists[index], address: true,token: token);
          },
        ),
      );
    }else{
      return SizedBox(width: 1,);
    }
  }

  @override
  Widget build(BuildContext context) {
//    final id = ModalRoute.of(context).settings.arguments;
    final userInfo = ScopedModel.of<Models>(context, rebuildOnChange: true).userInfo;
    final tokens = jsonDecode(jsonEncode(userInfo))['token'];

    setState(() {
      token = tokens;
    });

    // TODO: implement build
    Widget onpress(index){
      if(index == 0){
        Navigator.pushNamed(context, 'Home',arguments: {'id': index});
      }else if (index == 2){
        Navigator.pushNamed(context, 'personal',arguments: {'id': index});
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1EBDA8),
        title: Center(child: Text('购票'),),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Pannel(name: '景区介绍',url: '',),
            SizedBox(height: 5,),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 15,top: 10,bottom: 10),
              child: Text('热销门票',style: TextStyle(fontSize: 15,),),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 1,color: Color(0xffeeeeee),style: BorderStyle.solid)),
                color: Colors.white
              ),
            ),
            getLists(hotLists),
            SizedBox(height: 5,),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 15,top: 10,bottom: 10),
              child: Text('成人门票',style: TextStyle(fontSize: 15,),),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1,color: Color(0xffeeeeee),style: BorderStyle.solid)),
                  color: Colors.white
              ),
            ),
            getLists(adultLists),
            SizedBox(height: 5,),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 15,top: 10,bottom: 10),
              child: Text('学生门票',style: TextStyle(fontSize: 15,),),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1,color: Color(0xffeeeeee),style: BorderStyle.solid)),
                  color: Colors.white
              ),
            ),
            getLists(studentLists),

          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页'),),
          BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart), title: Text('购买')),
          BottomNavigationBarItem(icon: Icon(Icons.perm_identity), title: Text('个人中心')),
        ],
        selectedFontSize: 12,
        currentIndex: _tabIndex,
        selectedItemColor: Color(0xff1EBDA8),
        iconSize: 24,
        onTap: (index){
          onpress(index);
        },
      )
    );

  }
}
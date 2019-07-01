import 'package:flutter/material.dart';


class Personal extends StatefulWidget {
  @override
  _Personal createState() => new _Personal();
}

class _Personal extends State<Personal> {
  @override
  Widget build(BuildContext context) {

    final id = ModalRoute.of(context).settings.arguments;
    print(id);
    // TODO: implement build
    Widget onpress(index){
      if(index == 0){
        Navigator.pop(context);
      }else if(index == 1){
        Navigator.pushNamed(context, 'buyer',arguments: {'id': index});
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('个人中心'),),
      ),
      body: Container(
        child: Center(child: Text('个人中心'),),
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
  }
}
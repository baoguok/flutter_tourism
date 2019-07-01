import 'package:flutter/material.dart';


//class Buyer extends StatefulWidget {
//
//  @override
//  _Buyer createState() => new _Buyer();
//}

class Buyer extends StatelessWidget {
  int _tabIndex = 1;
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    print(id);
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
      ),
      body: Container(
        child: Text('购票'),
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
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/buyer.dart';
import 'package:flutter_app/pages/personal.dart';

void main() => runApp(MyApp());

//class MyApp extends StatefulWidget {
//  // This widget is the root of your application.
//  @override
//  _MyApp createState() => new _MyApp();
//}

//class _MyApp extends State<MyApp> {
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
//      home: Home(),
      initialRoute: "Home",
      routes: {
        'Home': (context) => Home(),
        'buyer': (context) => Buyer(),
        'personal': (context) => Personal(),
      },
    );
  }
}
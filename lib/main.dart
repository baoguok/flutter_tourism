import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_app/model/models.dart';

import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/buyer.dart';
import 'package:flutter_app/pages/personal.dart';
import 'package:flutter_app/pages/login.dart';
import 'package:flutter_app/pages/register.dart';
import 'pages/order.dart';

void main() => runApp(MyApp());

//class MyApp extends StatefulWidget {
//  // This widget is the root of your application.
//  @override
//  _MyApp createState() => new _MyApp();
//}

//class _MyApp extends State<MyApp> {
class MyApp extends StatelessWidget {
  Models models = Models();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<Models>(
      model: models,
      child: MaterialApp(
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
          'login': (context) => Login(),
          'register': (context) => Register(),
          'order': (context) => Order(),
        },
      ),
    );
  }
}




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_data_display_app/screens/homePage.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stocks',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home:  HomePage(),
    );
  }
}
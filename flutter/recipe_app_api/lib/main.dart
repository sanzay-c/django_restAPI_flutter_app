import 'package:flutter/material.dart';
// import 'package:recipe_app_api/screens/demo.dart';
import 'package:recipe_app_api/screens/home_screen.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      // home: Demo(),
    );
  }
}
import 'package:flutter/material.dart';
import 'Homepage.dart';
import 'GamePage.dart';
import 'Help.dart';
import 'Gamepage2.dart';
void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Play One Card!",
      initialRoute: '/HomePage',
      routes: {
        '/GamePage' : (context) => GamePage(),
        '/HomePage' : (context) => HomePage(),
        '/Help' : (context) => Help(),
        '/GamePage2' : (context) => GamePage2()
      },
    );
  }
}


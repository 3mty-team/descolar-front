import 'package:app/src/pages/home.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true, // turn to false before release
      theme: ThemeData(fontFamily: 'Roboto'),
      home: const HomePage(),
    );
  }
}
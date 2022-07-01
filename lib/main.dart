import 'package:flutter/material.dart';
import 'package:test_mysr_app/contants.dart';
import 'package:test_mysr_app/screens/garage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mysr test app',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: kPrimaryColor,
      ),
      home: const Garage(),
    );
  }
}

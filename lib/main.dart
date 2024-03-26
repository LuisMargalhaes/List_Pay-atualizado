import 'package:flutter/material.dart';
import 'package:list_pay/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends MaterialApp {
  MyApp({super.key})
      : super(
          home: HomePage(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(brightness: Brightness.dark),
        );
}

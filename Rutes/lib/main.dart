import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rutas/vista1.dart';
import 'package:rutas/vista2.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: 'My App',
      //home: vista(),
       initialRoute: '/',
      routes: {
        '/': (context) => vista(),
        '/secundary':(context) => vista2()
      },
    ),
  );
}


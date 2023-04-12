import 'package:log/login.dart';
import 'package:flutter/material.dart';

import 'home.dart';

void main() {
  runApp(
    MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'Datos Biometricos',
       initialRoute: '/',
      routes: {
        '/': (context) => HomeLog(),
        '/home': (context) => Home(userTxt: ModalRoute.of(context)!.settings.arguments as String),
      },
    ),
  );
}
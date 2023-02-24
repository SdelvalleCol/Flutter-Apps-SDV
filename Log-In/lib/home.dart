import 'package:flutter/material.dart';
import 'package:log/log.dart';

class vista extends StatelessWidget {
  const vista({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: MyHomePage(),
      )
    );
  }
}

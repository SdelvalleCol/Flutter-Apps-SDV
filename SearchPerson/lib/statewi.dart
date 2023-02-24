import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'miwdgt.dart';

class myclass extends StatefulWidget {
  const myclass({Key? key}) : super(key: key);
  @override
  view createState() => view();
}

class view extends State<myclass> {
  late List<Widget> informacion = [];
  bool load = true;
  @override
  void initState() {
    super.initState();
    getDatax();
  }

  Future<void> getDatax() async {
  final uri = Uri.parse("https://api.npoint.io/21d6b6f9061da4349f01");
  final response = await http.get(uri);
  final pa = await jsonDecode(response.body);
  List<Widget> tempInformacion = [];
  for (var i = 0; i < pa.length; i++) {
    var q = myw(
        pa[i]["img"], pa[i]["name"], pa[i]["email"], pa[i]["promedio"]);
    tempInformacion.add(q);
  }
  setState(() {
    informacion = tempInformacion;
    load = false;
  });
}

  List<Widget> p() {
    return this.informacion;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: load
              ? CircularProgressIndicator()
              : ListView(
                  children: informacion,
                ),
        ),
      ),
    );
  }
}

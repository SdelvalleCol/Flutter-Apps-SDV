import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:log/iniciouser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState(la: false);
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controlador_correo = TextEditingController();
  TextEditingController _controlador_password = TextEditingController();
  late SharedPreferences _prefs;
  bool la;
  _MyHomePageState({required this.la});

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    if (la == true) {
      _prefs.remove('correo');
    }
    _checkCookie();
  }

  String? getMiDato() {
    return _prefs.getString('correo');
  }

  Future<void> setMiDato(String miDato) async {
    await _prefs.setString('correo', miDato);
  }

  Future<void> _checkCookie() async {
    final cookie = getMiDato();
    var dato = getMiDato().toString();
    if (cookie != null) {
      final uri =
          Uri.parse("http://192.168.1.25:3000/api/post/verify/thens/" + dato);
      final response = await http.post(uri);
      final rta = response.body.toString();
      if (rta != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => vista2(
                    correo: rta,
                  )),
        );
      }
    }
  }

  void verificar(BuildContext context) async {
    if (_controlador_correo.text != null) {
      final uri = Uri.parse("http://192.168.1.25:3000/api/post/" +
          _controlador_correo.text +
          "/" +
          _controlador_password.text);
      final response = await http.post(uri);
      final rta = response.body.toString();
      if (_controlador_correo.text != "" && _controlador_password.text != "") {
        if (rta != "no") {
          setMiDato(rta);
          print(getMiDato());
          print("Correcto");
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => vista2(
                      correo: _controlador_correo.text,
                    )),
          );
        } else {
          print("No se encontra ningun objeto");
        }
      } else {
        print("Escriba el correo");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 100, bottom: 25),
              child: Container(
                margin: EdgeInsets.all(15),
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            Container(
              width: 350,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                    controller: _controlador_correo,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Ingresa tu correo',
                    )),
              ),
            ),
            Container(
              width: 350,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                    controller: _controlador_password,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Ingresa tu contraseña',
                    )),
              ),
            ),
            Container(
              width: 50,
              child: ElevatedButton(
                  onPressed: () async {
                    verificar(context);
                  },
                  child: Text("Presiona")),
            )
          ],
        ),
      ),
    );
  }
}

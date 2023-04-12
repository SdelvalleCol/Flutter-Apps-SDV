import 'package:flutter/material.dart';
import 'login.dart';
import 'package:local_auth/local_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Home extends StatefulWidget {
  final String userTxt;

  Home({required this.userTxt});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  TextEditingController _controlador_correo = TextEditingController();
  TextEditingController _controlador_password = TextEditingController();
  late bool estado = false;

  void inicio() async {
    final storage = new FlutterSecureStorage();
    String? value = await storage.read(key: "shared");
    if (value != null && value != "") {
      setState(() {
        estado = true;
      });
    } else {
      setState(() {
        estado = false;
      });
    }
  }

  Future<bool> verificar() async {
    final storage = new FlutterSecureStorage();
    String? value = await storage.read(key: "shared");
    if (value != null && value != "") {
      return true;
    } else {
      return false;
    }
  }

  //Metodos de huella
  Future<bool> _authenticateUser() async {
    final isAvailable = await _localAuthentication.canCheckBiometrics;
    final isDeviceSupported = await _localAuthentication.isDeviceSupported();
    return isAvailable && isDeviceSupported;
  }

  //activar desactivar huella
  Future<void> ingresarfinger(BuildContext context) async {
    bool isAuthenticated = false;
    bool isloguedx = await verificar();
    //ACTIVAR
    if (isloguedx == false) {
      try {
        isAuthenticated = await _localAuthentication.authenticateWithBiometrics(
          localizedReason: 'Authenticate to access the app',
          useErrorDialogs: true,
          stickyAuth: true,
        );
      } catch (e) {
        print('Error: $e');
      }
      if (isAuthenticated) {
        showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 300,
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("Activar"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("Confirmar Inicio Sesión"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                            controller: _controlador_correo,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Ingresa su correo',
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                            controller: _controlador_password,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Ingresa su contraseña',
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: ElevatedButton(
                            onPressed: () async {
                              if ((_controlador_correo.text != null &&
                                      _controlador_correo.text != "") &&
                                  (_controlador_password.text != null &&
                                      _controlador_password.text != "")) {
                                final uri = Uri.parse(
                                    "http://192.168.1.66:3000/api/post/${_controlador_correo.text}/${_controlador_password.text}");
                                final response = await http.post(uri);
                                final statusCode = response.statusCode;
                                if (statusCode == 200) {
                                  final storage = new FlutterSecureStorage();
                                  storage.write(
                                      key: "shared",
                                      value: response.body.toString());
                                  setState(() {
                                    inicio();
                                  });
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Alerta'),
                                        content: Text(
                                            'Se ha vinculado la huella dactilar con el usuario'),
                                        actions: [
                                          ElevatedButton(
                                            child: Text('OK'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }else{
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Alerta'),
                                        content: Text(
                                            'Parametros invalidos'),
                                        actions: [
                                          ElevatedButton(
                                            child: Text('OK'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              }
                            },
                            child: Text("Enviar")),
                      ),
                    ],
                  ),
                ),
              );
            });
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Acceso denegado'),
              content: Text(
                  'El programa no reconocio la huella , intenta mas tarde'),
              actions: [
                ElevatedButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
      //DESACTIVAR
    } else {
      try {
        isAuthenticated = await _localAuthentication.authenticateWithBiometrics(
          localizedReason: 'Authenticate to access the app',
          useErrorDialogs: true,
          stickyAuth: true,
        );
      } catch (e) {
        print('Error: $e');
      }
      if (isAuthenticated) {
        showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 200,
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("Desactivar"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Desactiva el inicio de sesión por huella",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: ElevatedButton(
                            onPressed: () async {
                              print("Yeah");
                              final storage = new FlutterSecureStorage();
                              String? value = await storage.read(key: "shared");
                              final uri = Uri.parse(
                                  "http://192.168.1.66:3000/api/des/token/${value}");
                              final response = await http.post(uri);
                              final statusCode = response.statusCode;
                              if (statusCode == 200) {
                                Navigator.pop(context);
                                setState(() {
                                  storage.delete(key: "shared");
                                  inicio();
                                });
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Alerta'),
                                      content: Text(
                                          'Se ha desactivado el inicio con huella'),
                                      actions: [
                                        ElevatedButton(
                                          child: Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Text("Enviar")),
                      ),
                    ],
                  ),
                ),
              );
            });
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Acceso denegado'),
              content: Text(
                  'El programa no reconocio la huella , intenta mas tarde'),
              actions: [
                ElevatedButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    inicio();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Hola De nuevo!",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Bienvenido ${widget.userTxt}"),
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Text("Hábilitar datos biometricos"),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                      onPressed: () async {
                        bool isAuthenticated = await _authenticateUser();
                        if (isAuthenticated) {
                          ingresarfinger(context);
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Dispositivo sin funcionalidad'),
                                content: Text(
                                    'Este dispositivo no tiene esta función'),
                                actions: [
                                  ElevatedButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      child: estado ? Text("Deshabilitar") : Text("Hábilitar")),
                )
              ],
            ),
            Container(
              width: 150,
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeLog(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  child: Text("Regresar")),
            ),
          ],
        ),
      ),
    );
  }
}

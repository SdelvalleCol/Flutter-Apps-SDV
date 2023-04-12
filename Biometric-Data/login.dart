import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeLog extends StatefulWidget {
  const HomeLog({Key? key}) : super(key: key);
  @override
  _HomeLogState createState() => _HomeLogState();
}

class _HomeLogState extends State<HomeLog> {
  //Controladores de texto
  TextEditingController _controlador_correo = TextEditingController();
  TextEditingController _controlador_password = TextEditingController();

  //Otros
  late bool isloged = false;
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  _HomeLogState();

  //Inicio
  void inicio() async {
    final storage = new FlutterSecureStorage();
    String? value = await storage.read(key: "shared");
    if ((value != null && value != "" && value.length > 2)) {
      setState(() {
        isloged = true;
      });
    } else {
      setState(() {
        isloged = false;
      });
    }
  }

  //Metodos de ingreso
  //Ingresa via texto
  void ingresar(String correo) async {
    if ((_controlador_correo.text != null && _controlador_correo.text != "") &&
        (_controlador_password.text != null &&
            _controlador_password.text != "")) {
      final uri = Uri.parse(
          "http://192.168.1.66:3000/api/post/ingreso/${_controlador_correo.text}/${_controlador_password.text}");
      final response = await http.post(uri);
      final statusCode = response.statusCode;
      if (statusCode == 200) {
        final rta = response.body.toString();
        setState(() {
          Navigator.pushNamed(context, '/home',
              arguments: _controlador_correo.text);
        });
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Datos incorrectos'),
              content: Text('Debe ingresar correctamente los parametros'),
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
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Párametros no identificados'),
            content: Text('Debe ingresar los parametros'),
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

  //Ingresa huella
  Future<void> ingresarfinger(BuildContext context) async {
    bool isAuthenticated = false;
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
      final storage = new FlutterSecureStorage();
      String? resultado = await storage.read(key: "shared");
      if (resultado != null && resultado!= "") {
        final uri =
            Uri.parse("http://192.168.1.66:3000/api/verify/user/${resultado}");
        final response = await http.post(uri);
        final statusCode = response.statusCode;
        if (statusCode == 200) {
          final rta = response.body.toString();
          Navigator.pushNamed(context, '/home', arguments: rta);
        }
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Acceso denegado'),
            content:
                Text('El programa no reconocio la huella , intenta mas tarde'),
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

  //Metodos de huella
  Future<bool> _authenticateUser() async {
    final isAvailable = await _localAuthentication.canCheckBiometrics;
    final isDeviceSupported = await _localAuthentication.isDeviceSupported();
    return isAvailable && isDeviceSupported;
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
        home: Scaffold(
            body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(15),
                child: Image.asset(
                  'assets/envio.png',
                  width: 100,
                  height: 100,
                ),
              ),
              Container(
                  width: 300,
                  padding: EdgeInsets.all(15),
                  child: TextField(
                      controller: _controlador_correo,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Ingresa tu correo',
                      ))),
              Container(
                  width: 300,
                  padding: EdgeInsets.all(15),
                  child: TextField(
                      controller: _controlador_password,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Ingresa tu contraseña',
                      ))),
              Container(
                  width: 200,
                  margin: EdgeInsets.all(15),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () async {
                      ingresar(_controlador_correo.text);
                    },
                    child: Text("Accede"),
                  )),
              this.isloged
                  ? ElevatedButton(
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
                      child: Text("Accede con huella"))
                  : Text("")
            ],
          ),
        )));
  }
}

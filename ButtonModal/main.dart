import 'package:flutter/material.dart';
import 'MBtnColor.dart';
import 'ModBtn.dart';
import 'ModRadio.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Modales',
      initialRoute: '/',
      routes: {
        '/': (context) => Myapp(),
        '/vista1': (context) => ModBtn(),
        '/vista2': (context) =>
            Mbelec(color: ModalRoute.of(context)!.settings.arguments as String),
        '/vista3': (context) => ModRadioColor(),
      },
    ),
  );
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Inicio",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Inicio", style: TextStyle(fontStyle: FontStyle.italic)),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 25),
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/vista1');
                  },
                  child: Text("VistaColor de Botones",
                      style: TextStyle(fontStyle: FontStyle.italic)),style: ButtonStyle(
                     backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  )
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/vista3');
                  },
                  child: Text("VistaColor de Selección",
                      style: TextStyle(fontStyle: FontStyle.italic)),
                  style: ButtonStyle(
                     backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

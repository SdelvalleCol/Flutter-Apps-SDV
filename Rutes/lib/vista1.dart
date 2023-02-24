import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rutas/vista2.dart';

class vista extends StatelessWidget {
  vista({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Vista1"),
        ),
        body: Container(
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => vista2()),
                    );
                  },
                  child: Text("Ir página 2 Push")),
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context,'/secundary');
              }, child: Text("Ir Página 2 PushNamed"))
            ],
          ),
        ),
      ),
    );
  }
}

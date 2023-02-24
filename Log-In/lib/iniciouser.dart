import 'package:flutter/material.dart';

class vista2 extends StatelessWidget {
  String correo;
  vista2({required this.correo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Bienvenido" + this.correo),
        ),
        body: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 500,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context,true);
                      },
                      child: Text("volver")),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

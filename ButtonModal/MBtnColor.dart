import 'package:flutter/material.dart';

class Mbelec extends StatelessWidget {
  final String color;
  late MaterialColor color_text;

  Mbelec({required this.color}) {
    if (this.color == "Naranja") {
      this.color_text = Colors.orange;
    } else if (this.color == "Rojo") {
      this.color_text = Colors.red;
    } else {
      this.color_text = MaterialColor(0xFFCE93D8, {
        50: Color(0xFFF3E5F5),
        100: Color(0xFFE1BEE7),
        200: Color(0xFFCE93D8),
        300: Color(0xFFBA68C8),
        400: Color(0xFFAB47BC),
        500: Color(0xFF9C27B0),
        600: Color(0xFF8E24AA),
        700: Color(0xFF7B1FA2),
        800: Color(0xFF6A1B9A),
        900: Color(0xFF4A148C),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Elección de color",
              style: TextStyle(fontStyle: FontStyle.italic)),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Text("Ud ha elegido el color"),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  this.color,
                  style: TextStyle(
                    color: color_text,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                width: 150,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Devolverse"),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

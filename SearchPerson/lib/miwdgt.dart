import 'package:flutter/material.dart';

class myw extends StatelessWidget {
  myw(String imgx, String nombrex, String correox, int puntajex) {
    this.img = imgx;
    this.nombre = nombrex;
    this.correo = correox;
    this.puntaje = puntajex;
  }

  late String img;
  late String nombre;
  late String correo;
  late int puntaje;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(91, 101, 193, 0.612),
      width: 50,
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Column(
              children: [
                Center(
                  child: ClipOval(
                    child: Image.network(
                      img,
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.all(11),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Text(nombre,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                              textAlign: TextAlign.left)
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Text(correo,
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            textAlign: TextAlign.left)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Text(puntaje.toString(),
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            textAlign: TextAlign.left)
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

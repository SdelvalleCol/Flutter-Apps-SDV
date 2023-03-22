import 'package:flutter/material.dart';

class ModBtn extends StatelessWidget {
  const ModBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title:
              Text("Color Bnt", style: TextStyle(fontStyle: FontStyle.italic)),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 150,
                                  child: ElevatedButton(
                                      child: const Text('Botón Lila'),
                                      onPressed: () => Navigator.pushNamed(
                                          context, '/vista2',
                                          arguments: "Lila"),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                MaterialColor(0xFFCE93D8, {
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
                                        })),
                                      )),
                                ),
                                Container(
                                  width: 150,
                                  child: ElevatedButton(
                                      child: const Text('Botón Rojo'),
                                      onPressed: () => Navigator.pushNamed(
                                          context, '/vista2',
                                          arguments: "Rojo"),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.red),
                                      )),
                                ),
                                Container(
                                  width: 150,
                                  child: ElevatedButton(
                                      child: const Text('Botón Naranja'),
                                      onPressed: () => Navigator.pushNamed(
                                          context, '/vista2',
                                          arguments: "Naranja"),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.orange),
                                      )),
                                ),
                                Container(
                                  width: 150,
                                  child: ElevatedButton(
                                      child: const Text('Cerrar'),
                                      onPressed: () => Navigator.pop(context),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.black),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    "Elegir color",
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
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

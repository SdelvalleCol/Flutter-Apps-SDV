import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ModRadioColor extends StatefulWidget {
  const ModRadioColor({super.key});

  @override
  State<ModRadioColor> createState() => _ModRadioColorState();
}

class _ModRadioColorState extends State<ModRadioColor> {
  late String opcion_s;
  late String subo = "";
  late String color;
  bool strike = true;
  late MaterialColor des = Colors.grey;
  _ModRadioColorState() {
    this.opcion_s = "Ninguna";
  }

  void xx(String p) {
    setState(() {
      opcion_s = p;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("RadioButtonModal",
              style: TextStyle(fontStyle: FontStyle.italic)),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 20),
                child: Text("Ud elegio el color${opcion_s}",
                    style: TextStyle(color: des, fontStyle: FontStyle.italic)),
              ),
              ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          if(strike != true){
                            subo = color;
                          }
                          return StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return Container(
                              height: 650,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ListTile(
                                      title: Text('Lila'),
                                      leading: Radio(
                                        value: 'Lila',
                                        groupValue: subo,
                                        onChanged: (value) {
                                          setState(() {
                                            subo = value.toString();
                                            des = MaterialColor(0xFFCE93D8, {
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
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      title: Text('Rojo'),
                                      leading: Radio(
                                        value: 'Rojo',
                                        groupValue: subo,
                                        onChanged: (value) {
                                          setState(() {
                                            subo = value.toString();
                                            des = Colors.red;
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      title: Text('Amarillo'),
                                      leading: Radio(
                                        value: 'Amarillo',
                                        groupValue: subo,
                                        onChanged: (value) {
                                          setState(() {
                                            subo = value.toString();
                                            des = Colors.yellow;
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      title: Text('Verde'),
                                      leading: Radio(
                                        value: 'Verde',
                                        groupValue: subo,
                                        onChanged: (value) {
                                          setState(() {
                                            subo = value.toString();
                                            des = Colors.green;
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      title: Text('Naranja'),
                                      leading: Radio(
                                        value: 'Naranja',
                                        groupValue: subo,
                                        onChanged: (value) {
                                          setState(() {
                                            subo = value.toString();
                                            des = Colors.orange;
                                          });
                                        },
                                      ),
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          xx(subo);
                                          this.strike = false;
                                          color = subo;
                                          Navigator.pop(context);
                                        },
                                        child: Text("Elegir")),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Cerrar"))
                                  ],
                                ),
                              ),
                            );
                            ;
                          });
                        });
                    ;
                  },
                  child: Text("Mostrar opciones"),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  )),
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

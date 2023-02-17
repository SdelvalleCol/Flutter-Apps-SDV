import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MivistaState extends StatelessWidget {
  MivistaState({super.key});
  TextEditingController controlador = TextEditingController();
  TextEditingController controlador_alertas = TextEditingController();

  void asignar(String x) {
    if (controlador.text.length > 0) {
      var ultimo = String.fromCharCode(
          controlador.text.runes.elementAt(controlador.text.length - 1));
      if ((x == "%" || x == "+" ||  x == "*" || x == "/")) {
        if (ultimo == "%" ||
            ultimo == "*" ||
            ultimo == "+" ||
            ultimo == "/") {
          controlador_alertas.text = "Sintaxis invalida";
        } else {
          controlador.text = controlador.text + x;
          controlador_alertas.text = "";
        }
      } else {
        controlador.text = controlador.text + x;
        controlador_alertas.text = "";
      }
    } else {
      controlador.text = controlador.text + x;
      controlador_alertas.text = "";
    }
  }

  void borrar() {
    controlador.text = "";
  }

  void borrar_ultimo() {
    if (controlador.text.length >= 1) {
      controlador.text =
          controlador.text.substring(0, controlador.text.length - 1);
    }
  }

  void calcular() {
    var data = controlador.text;
    try {
      var p = controlador.text;
      Parser q = Parser();
      Expression exp = q.parse(p);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      var answer = eval.toString();
      controlador.text = answer;
    } catch (e) {
      controlador.text = data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.all(1),
            child: SizedBox(
              width: 150,
              height: 50,
              child: TextField(
                controller: controlador_alertas,
                textAlign: TextAlign.center,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all((5)),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                width: 290,
                child: TextField(
                  controller: controlador,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    borrar();
                  },
                  child: const Text("AC"),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    borrar_ultimo();
                  },
                  child: const Text("CE"),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    asignar("%");
                  },
                  child: const Text("%"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    asignar("/");
                  },
                  child: const Text("/"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    asignar("7");
                  },
                  child: const Text("7"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    asignar("8");
                  },
                  child: const Text("8"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    asignar("9");
                  },
                  child: const Text("9"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    asignar("*");
                  },
                  child: const Text("X"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    asignar("4");
                  },
                  child: const Text("4"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    asignar("5");
                  },
                  child: const Text("5"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    asignar("6");
                  },
                  child: const Text("6"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    asignar("-");
                  },
                  child: const Text("-"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(children: [
                Padding(
                  padding: EdgeInsets.all(7),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          asignar("1");
                        },
                        child: const Text("1"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          asignar("2");
                        },
                        child: const Text("2"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          asignar("3");
                        },
                        child: const Text("3"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all((7)),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          asignar("0");
                        },
                        child: const Text("0"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          asignar(".");
                        },
                        child: const Text("."),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          calcular();
                        },
                        child: const Text("="),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey),
                      ),
                    ],
                  ),
                )
              ]),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: 70,
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          asignar("+");
                        },
                        child: const Text("+"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ])));
  }
}

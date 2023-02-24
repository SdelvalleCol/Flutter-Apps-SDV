import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rutas/vista1.dart';


class vista2 extends StatelessWidget {
  const vista2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Vista2"),
        ),
        body: Container(
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Ir página 1 POP")),
                  ElevatedButton(onPressed: (){
                    Get.to(vista());
                  }, child: Text("Ir página 1 Get"))
            ],
          ),
        ),
      ),
    );
  }
}

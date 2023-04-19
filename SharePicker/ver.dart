import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';

class imagen extends StatefulWidget {
  late File file;
  imagen({required this.file}) {
    this.file = file;
  }

  @override
  State<imagen> createState() => _imagenState(filep: this.file);
}

class _imagenState extends State<imagen> {
  late File filep;
  _imagenState({required this.filep}) {
    this.filep = filep;
  }

  Future<void> compartir() async {
    File imagen = this.filep;
    Share.shareFiles([imagen.path], text: 'Compartiendo mi imagen');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Share"),
          ),
          body: SizedBox(
            width: 1000,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 350,
                  padding: EdgeInsets.all(5),
                  child: filep != null
                      ? Image.file(filep!)
                      : Text('No image selected'),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  width: 100,
                  child: ElevatedButton(
                      onPressed: () async{
                        compartir();
                      }, child: Text("Compartir")),
                )
              ],
            ),
          )),
    );
  }
}

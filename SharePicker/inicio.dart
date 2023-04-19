import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sh/ver.dart';
import 'package:share/share.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
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
                  padding: EdgeInsets.all(5),
                  width: 100,
                  child: Text("Comparta o tome su imagen"),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  width: 100,
                  child: Builder(
                    builder: (BuildContext context) {
                      return ElevatedButton(
                        onPressed: () async {
                          final picker = ImagePicker();
                          final pickedFile = await picker.getImage(
                              source: ImageSource.gallery);
                          if (pickedFile != null) {
                            File p = File(pickedFile.path);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => imagen(file: p)),
                            );
                          }
                        },
                        child: Text("Galeria"),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  width: 100,
                  child: Builder(
                    builder: (BuildContext context){
                      return ElevatedButton(
                      onPressed: () async {
                        ImagePicker foto = ImagePicker();
                        final pickedFile = await foto.getImage(
                          source: ImageSource
                              .camera, 
                        );
                        if (pickedFile != null) {
                          File p = File(pickedFile.path);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => imagen(file: p)),
                          );
                        }
                      },
                      child: Text("Foto"));
                    },
                  )
                  
                )
              ],
            ),
          )),
    );
  }
}

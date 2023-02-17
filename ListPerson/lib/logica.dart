import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class vista extends StatelessWidget {
  vista({super.key});
  late List<Widget> informacion = [];

  void getDatax() async {
    final uri = Uri.parse("https://api.npoint.io/21d6b6f9061da4349f01");
    final response = await http.get(uri);
    final pa = jsonDecode(response.body);
    //var json =
    '[{"name": "Quynn Morgan","email": "nunc.est.mollis@yahoo.couk","promedio": 3,"img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScS89f9yjII_CvrRt-HzalJRDkL76a5x4rhQ&usqp=CAU"},{"name": "Leslie Hickman","email": "ipsum.dolor.sit@icloud.ca","promedio": 1,"img": "https://ichef.bbci.co.uk/news/640/cpsprodpb/6EE3/production/_97678382_okface.jpg"},{"name": "Jerome Marshall","email": "et.tristique@hotmail.ca","promedio": 5,"img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEQbgxixS_H09L2JUcVWVOAiHuL8w-kERhNg&usqp=CAU"},{"name": "Wyoming Reed","email": "mi.lacinia@yahoo.couk","promedio": 5,"img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRU-TieRNgbyRgYu6p7h5B3hJwDgMq9pBGDqA&usqp=CAU"},{"name": "Reese Solomon","email": "semper.cursus@yahoo.com","promedio": 7,"img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7ev8wpk05Gf9VDickf71bpIPyPvYENujAVg&usqp=CAU"},{"name": "Timon Abbott","email": "est.ac@aol.ca","promedio": 9,"img": "https://images.pexels.com/photos/2876486/pexels-photo-2876486.png?auto=compress&cs=tinysrgb&dpr=1&w=500"},{"name": "Aiko Watson","email": "id.nunc@icloud.couk","promedio": 9,"img": "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fHJvc3Ryb3N8ZW58MHx8MHx8&w=1000&q=80"}]';
    //var jsonList = jsonDecode(json) as List;
    for (var i = 0; i < pa.length; i++) {
      var q = Container(
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
                        pa[i]["img"],
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
                            Text(pa[i]["name"],
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255)),
                                textAlign: TextAlign.left)
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Text(pa[i]["email"],
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
                          Text(pa[i]["promedio"].toString(),
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
      informacion.add(q);
    }
  }

  @override
  Widget build(BuildContext context) {
    getDatax();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Lista-Personas"),
          ),
          backgroundColor: Color.fromRGBO(91, 101, 193, 0.612),
        ),
        body: Container(
          alignment: Alignment.center,
          child: ListView(
            children: informacion,
          ),
        ),
      ),
    );
  }
}

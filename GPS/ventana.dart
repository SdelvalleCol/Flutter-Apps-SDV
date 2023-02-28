import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class ventana extends StatelessWidget {
  const ventana({super.key});

  Future<Position> obtenerGps() async {
    bool bGpsHabilitado = await Geolocator.isLocationServiceEnabled();
    if (!bGpsHabilitado) {
      return Future.error('Por favor habilite el servicio de ubicación.');
    }
    LocationPermission bGpsPermiso = await Geolocator.checkPermission();
    if (bGpsPermiso == LocationPermission.denied) {
      bGpsPermiso = await Geolocator.requestPermission();
      if (bGpsPermiso == LocationPermission.denied) {
        return Future.error('Se denegó el permiso para obtener la ubicación.');
      }
    }
    if (bGpsPermiso == LocationPermission.deniedForever) {
      return Future.error(
          'Se denegó el permiso para obtener la ubicación de forma permanente.');
    }
     return await Geolocator.getCurrentPosition();
  }

  Future<void> abrirUrl(final String sUrl) async {
    final Uri oUri = Uri.parse(sUrl);
    try {
      await launchUrl(
          oUri, 
          mode: LaunchMode.externalApplication);
    } catch (oError) {
      return Future.error('No fue posible abrir la url: $sUrl.');
    }
  }

  Future <void> obtenerl() async{
    print("xd");
    Position posicion = await obtenerGps();
    var lat = posicion.latitude;
    var lng = posicion.longitude;
    String url = "geo:${lat.toString()},${lng.toString()}";
    abrirUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ElevatedButton(onPressed: () async
          {
            obtenerl();
          }, child: Text("Obtener ubicación"))],
        ),
      ),
    );
  }
}

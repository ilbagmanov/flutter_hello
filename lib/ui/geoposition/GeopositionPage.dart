import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeopositionPage extends StatelessWidget {
  String location = "no";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: FutureBuilder(
          future: Geolocator.getCurrentPosition(),
          builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
            if (snapshot.hasData) {
              Position position = snapshot.requireData;
              return Text('Lat: ${position.latitude}, Long: ${position.longitude}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );

  }

  Future<String> getData() async {
    Future<Position> position =
        Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var value = await position;
    location = "---- $value.longitude $value.latitude";

    return location;
  }

  void someFunction() async {
    String data = await getData();
    // Здесь можно обработать полученные данные
    print(data); // "data"
  }
}

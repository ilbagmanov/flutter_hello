import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeopositionPage extends StatelessWidget {
  String location = "no";

  @override
  Widget build(BuildContext context) {
    Future<Position> position =
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    position.then((value) => () {
      location = "---- $value.longitude $value.latitude";
    });

    return Scaffold(
      body: Center(
        child: Text(
          'Location: $location',
          style: TextStyle(fontSize: 20),

        ),
      ),
    );
  }

}

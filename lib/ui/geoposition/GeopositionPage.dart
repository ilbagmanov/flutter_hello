import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GeopositionPage extends StatelessWidget {
  String location = "no";

  @override
  Widget build(BuildContext context) {
    GyroscopeEvent gyroscope = GyroscopeEvent(0, 0, 0);
    gyroscopeEvents.listen(
      (GyroscopeEvent event) {
        gyroscope = event;
      },
      onError: (error) {},
      cancelOnError: true,
    );
    UserAccelerometerEvent accelerometer = UserAccelerometerEvent(0, 0, 0);
    userAccelerometerEvents.listen(
      (UserAccelerometerEvent event) {
        accelerometer = event;
      },
      onError: (error) {},
      cancelOnError: true,
    );

    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: FutureBuilder(
          future: Geolocator.getCurrentPosition(),
          builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
            if (snapshot.hasData) {
              Position position = snapshot.requireData;
              return Text(
                  'Lat: ${position.latitude}, Long: ${position.longitude}\nAccelerometer x:${accelerometer.x} y:${accelerometer.y} z:${accelerometer.x}\nGyroscope x:${gyroscope.x} y:${gyroscope.x} z:${gyroscope.x}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),);
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

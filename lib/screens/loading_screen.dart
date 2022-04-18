import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = WeatherModel().getLocationWeather();
    //I should probably remove what wraps the navigator
    //WidgetsBinding.instance?.addPostFrameCallback((context) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return LocationScreen(
              locationWeather: weatherData,
            );
          },
        ),
      );
    //});
  }

  void checkForPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
  }

  void requestForPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitRotatingCircle(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}

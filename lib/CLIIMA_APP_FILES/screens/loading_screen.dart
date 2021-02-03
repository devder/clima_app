// import 'package:clima_app/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import '../services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  //added code to XML for android and info list for ios
  void getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();

    //commented bc i added great places app to here
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => LocationScreen(
    //                 locationWeather: weatherData,
    //               )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SpinKitRotatingCircle(
        color: Colors.white,
        size: 100.0,
      )),
    );
  }
}
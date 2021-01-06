import 'dart:convert';

import 'package:clima/get_weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String weatherApi = "YOUR API";

  String currentWeatherApiUrl = "api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherData();

  }


  void getWeatherData()async{
    print("Get Weather Scrren");
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

    var latitude = position.latitude;
    var longitude = position.longitude;

    var weatherurl = "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$weatherApi";
    final response = await http.get(weatherurl);
    if(response.statusCode == 200){
      //Means Success

      var weatherData = jsonDecode(response.body) ;
      Navigator.push(context, MaterialPageRoute(builder:(context)=> GetWeatherScreen(weatherData: weatherData,)));
    }else{
      // Means Error
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: SpinKitDoubleBounce(
            color: Colors.grey,
            size: 50,
        ),
        ),
      );

  }
}

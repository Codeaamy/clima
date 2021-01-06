import 'dart:convert';

import 'package:clima/get_city_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;



class GetWeatherScreen extends StatefulWidget {
  final weatherData;

  const GetWeatherScreen({Key key, this.weatherData}) : super(key: key);
  @override
  _GetWeatherScreenState createState() => _GetWeatherScreenState();
}

class _GetWeatherScreenState extends State<GetWeatherScreen> {

  String weatherApi = "Enter Your API";

  double tempInCelcius;
  String currentWeather = "";
  String cityName = "";

 var weatherData ;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weatherData = widget.weatherData;
    updateUi(weatherData);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height ,
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/location_background.jpg', ), fit: BoxFit.cover),

        ),
        child: SafeArea(
          child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        //Button 1
                        IconButton(
                          icon: Icon(Icons.near_me, color: Colors.white, size: 50,),
                          onPressed: () async {


                            print("Current Location Button Pressed");
                            var weatherData = await getCurrentWeatherData();
                            updateUi(weatherData);


                          },
                        ),
                        Spacer(),
                        //Button2
                        IconButton(icon: Icon(Icons.location_on, color: Colors.white, size: 50,),
                        onPressed: ()async{
                          print("Location Button Pressed");
                         var cityName = await Navigator.push(context, MaterialPageRoute(builder: (context)=> GetCityScreen()));
                         print("After Navigator Pop.........${cityName}");
                         if(cityName != null || cityName != ""){
                           var weatherData = await getWeatherByCityName(cityName);
                           setState(() {
                             updateUi(weatherData);

                           });
                         }
                        },
                        )
                      ],
                    ),
                  ),
                  Text("${cityName}", style: TextStyle(
                    color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold
                  ),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30, top: 20),
                            child: Text("${tempInCelcius.round()}° ", style: TextStyle(
                              color: Colors.white, fontSize: 50, fontWeight: FontWeight.w500,
                            ),),
                          ),
                          Text("${currentWeather}", style: TextStyle(
                            color: Colors.white, fontSize: 50, fontWeight: FontWeight.w500,
                          ),
                          ),
                        ],
                      ),
                      Text('☀️', style: TextStyle(fontSize: 100),),


                    ],


                  ),
                ],
              )
          ),
        ),
      ),
    );
  }
 Future getWeatherByCityName(String cityName)async{
   var apiurl = "https"
       "://api.openweathermap.org/data/2.5/weather?q=${cityName}&appid=${weatherApi}";
   final response = await http.get(apiurl);
   var body;
   if(response.statusCode == 200){
     body = jsonDecode(response.body);

     return body;
   }else{
     return "Error";
   }

 }

 updateUi(weatherData){
    setState(() {

   var tempInKelvin = weatherData['main']['temp'];
   tempInCelcius = tempInKelvin - 273.15;
   currentWeather = weatherData['weather'][0]['main'];
   cityName = weatherData['name'];
    });

 }

  Future getCurrentWeatherData()async{
    print("Get Weather Scrren");
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

    var latitude = position.latitude;
    var longitude = position.longitude;

    var weatherurl = "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$weatherApi";
    final response = await http.get(weatherurl);
    if(response.statusCode == 200){
      //Means Success

      var weatherData = jsonDecode(response.body) ;
      return weatherData;
    }else{
      // Means Error
    }

  }
}


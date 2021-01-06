import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class GetCityScreen extends StatefulWidget {
  @override
  _GetCityScreenState createState() => _GetCityScreenState();
}

class _GetCityScreenState extends State<GetCityScreen> {

  TextEditingController cityNameController = TextEditingController();
  String weatherApi = "Enter Your API";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height ,
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('images/city.jpg', ), fit: BoxFit.cover),

      ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left:16.0),
              child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 40,),
              onPressed: (){
                  Navigator.pop(context);
              },

               ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0, top: 20),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: Colors.white, size: 50,),
                  SizedBox(width: 10),
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: TextFormField(

                      controller: cityNameController,
                      decoration: InputDecoration(
                        hintText: 'Enter City Name',
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.all(5.0),
                        focusColor: Colors.blue,

                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: Center(
                  child: Text("Get Weather", style: TextStyle(
                    fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold
                  ),),
                ),
                onTap: (){
                  //Get Weather Print,
//                  print(cityNameController.text);
                  Navigator.pop(context, cityNameController.text);
                },
              ),
            )

          ],
        )
      ),
    );
  }


}

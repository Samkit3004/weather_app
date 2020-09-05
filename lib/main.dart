import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String apif = 'http://api.openweathermap.org/data/2.5/weather?q=';
  String apil = '&units=metric&appid=deaf5261d8a67bcc2113e008837d1605';
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather(String input) async {
    http.Response response = await http.get(apif + input + apil);
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: TextField(
                    onSubmitted: (String input) {
                      getWeather(input);
                    },
                    style: TextStyle(color: Colors.white, fontSize: 25),
                    decoration: InputDecoration(
                      hintText: 'Search for a city',
                      hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                ),
                Text(
                  temp != null
                      ? temp.toString() + '\u00B0 C'
                      : 'Enter a city!!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    currently != null ? currently.toString() : '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text('Temperature'),
                    trailing: Text(
                        temp != null ? temp.toString() + '\u00B0 C' : '-_-'),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text('Weather'),
                    trailing: Text(
                        description != null ? description.toString() : '-_-'),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text('Humidity'),
                    trailing:
                        Text(humidity != null ? humidity.toString() : '-_-'),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text('Wind'),
                    trailing:
                        Text(windSpeed != null ? windSpeed.toString() : '-_-'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

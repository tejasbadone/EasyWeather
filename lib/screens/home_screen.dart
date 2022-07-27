import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'city_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.locationWeather});
  final locationWeather;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherModel weather = WeatherModel();
  late int temperature;
  late String condition;
  late String weatherIcon;
  late String cityName;
  late String weatherMessage;

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }
      var temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      condition = weatherData['weather'][0]['main'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            color: whiteColor,
            child: ListView(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.place,
                      size: 35,
                      color: blueColor,
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      '$cityName',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: blueColor),
                    )
                  ],
                ).pOnly(top: 30.0, left: 30.0, bottom: 10.0),
                Center(
                  child: SimpleShadow(
                    opacity: 0.8, // Default: 0.5
                    color: whiteColor, // Default: Black
                    offset: Offset(0, 6), // Default: Offset(2, 2)
                    sigma: 10,
                    child: BackG(
                      imageName: weatherIcon,
                    ).p32(),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '$condition',
                      style: kMessageTextStyle,
                    ),
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    )
                  ],
                ).pOnly(bottom: 50.0),
                Card(
                  elevation: 0.0,
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(Icons.gps_fixed,
                            size: 30.0, color: Color(0xff283B6F)),
                        onPressed: () async {
                          var weatherData = await weather.getLocationWeather();
                          updateUI(weatherData);
                        },
                        iconSize: 50.0,
                      ),
                      IconButton(
                        icon: Icon(Icons.search,
                            size: 30.0, color: Color(0xff283B6F)),
                        onPressed: () async {
                          var typedName = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return CityScreen();
                              },
                            ),
                          );
                          if (typedName != null) {
                            var weatherData =
                                await weather.getCityWeather(typedName);
                            updateUI(weatherData);
                          }
                        },
                        iconSize: 50.0,
                      )
                    ],
                  ),
                ),
                50.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BackG extends StatelessWidget {
  // const ({Key? key}) : super(key: key);
  BackG({required this.imageName});
  final String imageName;
  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage('images/$imageName'),
      height: 300,
      width: 300,
    ).p16();
  }
}

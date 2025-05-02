import "package:flutter/material.dart";
import "package:lottie/lottie.dart";
import "package:weather_app/models/weather_model.dart";
import "package:weather_app/services/weather_service.dart";

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //  api key
  final _weatherService = WeatherService('e7e06f53fefef65bceb4f8c13b3f88b6');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherService.getcurrentCity();

    // get weather for city
    try {
      Weather weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      // handle error
      print("Error fetching weather: $e");
    }
  }

  // weather animation
  String getWeatheranimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json'; // default to sunny

    switch (mainCondition.toLowerCase()) {
      case 'cloud':
      case 'mist':
      case 'smoke':
      case 'fog':
      case 'dust':
      case 'haze':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  // init state
  @override
  void initState() {
    super.initState();

    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // city name
          Text(
            _weather?.cityName ?? "Loading city",
          ),

          // animation
          Lottie.asset(getWeatheranimation(_weather?.Maincondition)),

          // temperature
          Text("${_weather?.temperature.round()}°C"),
          // weather condition
          Text(_weather?.Maincondition ?? ""),
        ],
      ),
    ));
  }
}

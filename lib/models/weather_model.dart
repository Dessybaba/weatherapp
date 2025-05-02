class Weather {
  final String cityName;
  final double temperature;
  final String Maincondition;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.Maincondition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      Maincondition: json['weather'][0]['main'],
    );
  }
}
import 'package:mobile/API/Villes/models/city.dart';

class MeteoCity {
  City city;
  List<dynamic> hourly;
  List<dynamic> temperatureHourly;
  List<dynamic> humidityHourly;
  List<dynamic> temperatureRessentie;
  List<dynamic> weathercodeHourly;

  List<dynamic> date;
  List<dynamic> weathercodeday;
  List<dynamic> tempMaxday;
  List<dynamic> tempMinday;
  List<dynamic> precipitationProbability;
  List<dynamic> windSpeed;
  List<dynamic> windDirection;



  MeteoCity({required this.city,
    required this.hourly,
    required this.temperatureHourly,
    required this.humidityHourly,
    required this.temperatureRessentie,
    required this.weathercodeHourly,
    required this.date,
    required this.weathercodeday,
    required this.tempMaxday,
    required this.tempMinday,
    required this.precipitationProbability,
    required this.windSpeed,
    required this.windDirection});

  double TemperatureActuelle(String Time) {
    return temperatureHourly[hourly.indexOf(Time)];
  }

  double TemperatureMin(String Time) {
    return temperatureHourly[hourly.indexOf(Time)];
  }

  String getWindDirection(int azimuth) {
    List<String> directions = [
      'N', 'NNE', 'NE', 'ENE', 'E', 'ESE', 'SE', 'SSE',
      'S', 'SSO', 'SW', 'OSO', 'W', 'ONO', 'NO', 'NNO'
    ];

    int index = ((azimuth + 11.25) / 22.5).round() % 16;
    return directions[index];
  }
}
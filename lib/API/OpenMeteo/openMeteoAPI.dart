import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mobile/API/OpenMeteo/models/meteoCity.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/API/OpenMeteo/request/requestMeteoCity.dart';
import 'package:mobile/API/Villes/models/city.dart';

class OpenMeteoAPI {

  Future<MeteoCity> getInfoMeteo(City city) async {

    try {
      final response = await http.get(Uri.http('api.open-meteo.com', '/v1/forecast', RequestMeteoCity(city: city).toMap()));

      if(response.statusCode == 200){
        var responseData = json.decode(response.body);
        MeteoCity a = MeteoCity(city: city, hourly: responseData['hourly']['time'],
            temperatureHourly: responseData['hourly']['temperature_2m'], humidityHourly: responseData['hourly']['relativehumidity_2m'],
            temperatureRessentie: responseData['hourly']['apparent_temperature'], weathercodeHourly: responseData['hourly']['weathercode'],
            date: responseData['daily']['time'], weathercodeday: responseData['daily']['weathercode'], tempMaxday: responseData['daily']['temperature_2m_max'],
            tempMinday: responseData['daily']['temperature_2m_min'], precipitationProbability: responseData['daily']['precipitation_probability_max'],
            windSpeed: responseData['daily']['windspeed_10m_max'], windDirection: responseData['daily']['winddirection_10m_dominant']);

        return a;
      }
    } catch (erreur){
      if (kDebugMode) {
        print(erreur);
      }
    }

    return MeteoCity(city: city, hourly: [],
        temperatureHourly: [], humidityHourly: [],
        temperatureRessentie: [], weathercodeHourly: [],
        date: [], weathercodeday: [], tempMaxday: [],
        tempMinday: [], precipitationProbability: [],
        windSpeed: [], windDirection: []);


  }
}
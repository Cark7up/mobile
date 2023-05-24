import 'package:mobile/API/Villes/models/city.dart';

class RequestMeteoCity {

  final City city;

  RequestMeteoCity({required this.city});

  Map<String, dynamic> toMap() {
    final querryParameters = {
      'latitude':'${city.lat}',
      'longitude':'${city.lon}',
      'hourly':'temperature_2m,relativehumidity_2m,apparent_temperature,weathercode',
      'daily':'weathercode,temperature_2m_max,temperature_2m_min,precipitation_probability_max,windspeed_10m_max,winddirection_10m_dominant',
      'timezone':'Europe/Berlin'
    };
    return querryParameters;
  }

  City get CityQ {
    return this.city;
  }

}
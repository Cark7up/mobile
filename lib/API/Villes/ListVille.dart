import 'dart:convert';

import 'package:mobile/API/Villes/models/city.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/API/Villes/request/requestVilles.dart';

class ListVille {


  Future<List<City>> fetchCities(String nameRec) async {

    final response = await http.get(Uri.http('geocoding-api.open-meteo.com','/v1/search', RequestVille(name: nameRec).toMap()));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['results'];
      if (data == null){
        return [];
      }
      final result = List<Map<String, dynamic>>.from(
          data);
      return result.map<City>((item) {
        return City(
          name: item['name'],
          lat: item['latitude'],
          lon: item['longitude'],
          country: item['country']?? "N/A",
        );
      }).toList();
    } else {
      throw Exception('Erreur lors de la récupération des données');
    }
  }

}
class City {
  String name;
  dynamic lon;
  dynamic lat;
  String country;

  City({required this.name, required this.lon, required this.lat, required this.country});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'],
      lon: json['lon'],
      lat: json['lat'],
      country: json['country'],
    );
  }

  @override
  bool operator ==(other){
    return other is City && other.name == name && other.country == country && other.lon == lon && other.lat == lat;
  }
}
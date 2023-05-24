import 'package:mobile/API/OpenMeteo/models/meteoCity.dart';

class VilleState {

  MeteoCity meteo;
  DateTime datetime;
  String datestr;

  VilleState({required this.meteo, required this.datetime, required this.datestr});

  VilleState copyWith({MeteoCity? meteocity, DateTime? datetime, String? reslut}) {
    return VilleState(
        meteo: meteocity ?? this.meteo,
        datetime: datetime ?? this.datetime,
        datestr: reslut ?? this.datestr
    );
  }
}
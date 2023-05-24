import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/API/OpenMeteo/models/meteoCity.dart';
import 'package:mobile/UI/Pages/Ville/bloc/VilleEvent.dart';
import 'package:mobile/UI/Pages/Ville/bloc/VilleState.dart';
import 'package:mobile/resources/WorldTime.dart';

class VilleBloc extends Bloc<VilleEvent, VilleState> {
  final MeteoCity city;
  final DateTime time;
  final String datestr;
  VilleBloc({required this.city, required this.time, required this.datestr}) : super(VilleState(meteo: city, datetime: time, datestr: datestr)){
    on<TimeNow>(timeNow);
  }

  Future<FutureOr<void>> timeNow(TimeNow event, Emitter<VilleState> emit) async {
    String time;
    DateTime datetime;

    final _worldtimePlugin = Worldtime();
    final String myFormatter = '\\Y-\\M-\\DT\\h:00';

    final DateTime timeAmsterdamGeo = await _worldtimePlugin.timeByLocation(
      latitude: state.meteo.city.lat,
      longitude: state.meteo.city.lon,
    );
    datetime = timeAmsterdamGeo;

    time = _worldtimePlugin.format(dateTime: timeAmsterdamGeo, formatter: myFormatter);

    emit(state.copyWith(datetime: datetime, reslut: time));
  }
}
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/API/OpenMeteo/openMeteoAPI.dart';
import 'package:mobile/UI/MyApp/bloc/FlowCubit.dart';
import 'package:mobile/UI/Pages/MesVilles/bloc/MesVillesEvent.dart';
import 'package:mobile/UI/Pages/MesVilles/bloc/MesVillesState.dart';
import 'package:mobile/resources/WorldTime.dart';


class MesVillesBloc extends Bloc<MesVillesEvent, MesVillesState> {
  final FlowCubit flowCubit;

  MesVillesBloc({required this.flowCubit}) : super(MesVillesState()){
    on<fetchInfoMeteo>(fetchinfoMeteoApi);
  }

  Future<void> fetchinfoMeteoApi(fetchInfoMeteo event, Emitter<MesVillesState> emit) async {
    List render = [];
    List<String> time = [];
    List<DateTime> datetime = [];

    final _worldtimePlugin = Worldtime();
    final String myFormatter = '\\Y-\\M-\\DT\\h:00';

    await Future.wait(flowCubit.cities.map((city) async {
      var obj = await OpenMeteoAPI().getInfoMeteo(city);
      render.add(obj);

      final DateTime timeAmsterdamGeo = await _worldtimePlugin
          .timeByLocation(latitude: city.lat, longitude: city.lon);
      datetime.add(timeAmsterdamGeo);

      final String resultGeo = _worldtimePlugin
          .format(dateTime: timeAmsterdamGeo,formatter:myFormatter);
      time.add(resultGeo);
    }));

    emit(state.copyWith(meteocity: render, reslut: time, datetime: datetime));
  }
}
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/API/Villes/models/city.dart';
import 'package:mobile/UI/MyApp/bloc/FlowCubit.dart';
import 'package:mobile/UI/Pages/Recherche/bloc/RechercheEvent.dart';
import 'package:mobile/UI/Pages/Recherche/bloc/RechercheState.dart';
import 'package:mobile/API/Villes/ListVille.dart';

class RechercheBloc extends Bloc<RechercheEvent, RechercheState> {
  final FlowCubit flowCubit;

  RechercheBloc({required this.flowCubit}) : super(RechercheState(search: TextEditingController())) {
    on<ClicOnCity>(CitySelected);
    on<TapSearch>(TapSearchResult);
    on<TapUpdate>(TapUpdateResult);
  }
  


  FutureOr<void> CitySelected(ClicOnCity event, Emitter<RechercheState> emit) {
  }

  Future<FutureOr<void>> TapSearchResult(TapSearch event, Emitter<RechercheState> emit) async {
    if(state.search.text.length > 1) {
      List<City> cities = await ListVille().fetchCities(state.search.text);
      /*var filteredCities = cities
        .where((city) =>
        city.name.toString().toLowerCase().contains(state.search.text))
        .toList();*/
      emit(state.copyWith(cities: cities));
    }
    else
      {
        List<City> cities = [];
        emit(state.copyWith(cities: cities));
      }
  }

  FutureOr<void> TapUpdateResult(TapUpdate event, Emitter<RechercheState> emit) {
    print(state.search.text);
  }
}
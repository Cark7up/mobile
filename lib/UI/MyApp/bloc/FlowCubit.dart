import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/API/Villes/models/city.dart';
import 'package:mobile/UI/MyApp/bloc/FlowState.dart';

class FlowCubit extends Cubit<FlowState> {
  FlowCubit() : super(RechercheState()) {

  }

  List<City> cities = [];


  void showMesvilles(City city) {
    if(!this.cities.contains(city)){ this.cities.add(city);}
    emit(MesVillesState());
  }
  void showRecherche() => emit(RechercheState());

  List<City> get Cities {
    return this.cities;
  }
}
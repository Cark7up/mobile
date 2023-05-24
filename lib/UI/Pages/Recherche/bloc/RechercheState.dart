import 'package:flutter/material.dart';

class RechercheState {

  List cities = [];
  TextEditingController search = TextEditingController();

  RechercheState({this.cities = const [], required this.search});

  RechercheState copyWith({List? cities}) {
    return RechercheState(
      cities: cities ?? this.cities,
      search: this.search
    );
  }

}
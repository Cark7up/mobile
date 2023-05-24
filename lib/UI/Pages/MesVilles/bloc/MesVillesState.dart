class MesVillesState {

  List MeteoCity = [];
  List<String> resultTime = [];
  List<DateTime> datetime = [];

  MesVillesState({this.MeteoCity = const [], this.resultTime = const [], this.datetime = const []});

  MesVillesState copyWith({List? meteocity, List<String>? reslut, List<DateTime>? datetime}) {
    return MesVillesState(
      MeteoCity: meteocity ?? this.MeteoCity,
      resultTime: reslut ?? this.resultTime,
      datetime: datetime ?? this.datetime
    );
  }

}
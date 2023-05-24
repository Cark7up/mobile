import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/UI/MyApp/bloc/FlowCubit.dart';
import 'package:mobile/UI/Pages/MesVilles/bloc/MesVillesEvent.dart';
import 'package:mobile/UI/Pages/MesVilles/bloc/MesVillesState.dart';
import 'package:mobile/UI/Pages/MesVilles/bloc/MesvillesBloc.dart';
import 'package:mobile/UI/Pages/Ville/view/Ville.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/resources/weatherCode.dart';

class MesVilles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => MesVillesBloc(flowCubit: context.read<FlowCubit>())..add(fetchInfoMeteo()),
      child: Scaffold(
        appBar: AppBar(title: Text("Mes villes", style: TextStyle(fontWeight: FontWeight.bold)),
          actions: <Widget>[
            IconButton(
                onPressed: () => context.read<FlowCubit>().showRecherche(),
                icon: const Icon(Icons.add_rounded, size: 32,))
          ],
        ),
        body: VilleMet(context),
      )
    );
  }
}

Widget VilleMet(BuildContext context) {
  return BlocBuilder<MesVillesBloc, MesVillesState>(
    builder: (BuildContext context, MesVillesState state) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: state.MeteoCity.length,
          itemBuilder: (_, index) => Padding(padding: EdgeInsets.only(right: 16,left: 16,bottom: 8,top: 8),
          child: GestureDetector(
            onTap: () {Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Ville(meteocity: state.MeteoCity[index], time: state.datetime[index], datestr: state.resultTime[index]),
                ));},
            child: Card(
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16, top: 16, bottom: 0),
                            child: Container(
                              width: double.infinity,
                              child: ClipRect(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "${state.MeteoCity[index].city.name}, ${state.MeteoCity[index].city.country}",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16, top: 8),
                            child: Text(
                              "${state.MeteoCity[index].TemperatureActuelle(state.resultTime[index]).round()}°",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16, top: 0, bottom: 16),
                            child: Text(
                              getStringCode(state.MeteoCity[index].weathercodeHourly[state.MeteoCity[index].hourly.indexOf(state.resultTime[index])], state.datetime[index]),
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16, right: 16),
                      child: SvgPicture.asset(
                        getImageCode(state.MeteoCity[index].weathercodeHourly[state.MeteoCity[index].hourly.indexOf(state.resultTime[index])], state.datetime[index], false),
                        width: 64,
                        height: 64,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          )
      );
    },
  );
}
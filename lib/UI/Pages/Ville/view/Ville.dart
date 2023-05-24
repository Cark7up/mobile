import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/API/OpenMeteo/models/meteoCity.dart';
import 'package:mobile/UI/Pages/Ville/bloc/VilleBloc.dart';
import 'package:mobile/UI/Pages/Ville/bloc/VilleEvent.dart';
import 'package:mobile/UI/Pages/Ville/bloc/VilleState.dart';
import 'package:mobile/resources/resources.dart';
import 'package:mobile/resources/weatherCode.dart';

class Ville extends StatelessWidget{

  Ville({super.key, required this.meteocity, required this.time, required this.datestr});

  final MeteoCity meteocity;
  final DateTime time;
  final String datestr;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_)=> VilleBloc(city: meteocity, time: time, datestr: datestr)..add(TimeNow()),
    child: Scaffold(
      appBar: AppBar(title: BlocBuilder<VilleBloc, VilleState>(
          builder: (BuildContext context, VilleState state) {
            return Text("${state.meteo.city.name}, ${state.meteo.city.country}", style: TextStyle(fontWeight: FontWeight.bold));
          }
          ),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_sharp, size: 32,color: Colors.black,)),
      ),

      body: SingleChildScrollView(
          child: Column(
            children: [
              VilleMet(context),
              Previsions(context),
              PlusInfo2(context),
            ],
          )
      ),
    )
    );
  }

}


Widget PlusInfo2(BuildContext context){
  return BlocBuilder<VilleBloc, VilleState>(
      builder: (BuildContext context, VilleState state) {
        return Container(
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    child: Padding(padding: EdgeInsets.all(16),
                      child: Text("Plus d'infos", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 20),)
                    )
                ),

                Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: Padding(
                          padding: EdgeInsets.all(8),
                            child: Container(
                              width: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Chances de pluie", style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                                  SvgPicture.asset(Images.rainDrops3, color: Colors.black, height: 48),
                                  Text("${state.meteo.precipitationProbability[0]}%", style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),)
                                ],
                              ),
                            )
                          ),
                        ),
                        Flexible(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Container(
                                width: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Taux d'humidité", style: TextStyle(fontWeight: FontWeight.bold, ), textAlign: TextAlign.center,),
                                    SvgPicture.asset(Images.rain, color: Colors.black, height: 48,),
                                    Text("${state.meteo.humidityHourly[0]}%", style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),)
                                  ],
                                ),
                              )
                            )
                        )
                      ],
                    ),
                ),

                Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                            child: Padding(padding: EdgeInsets.all(8),
                                child: Container(
                                  width: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("Vent", style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                                      SvgPicture.asset(Images.windy1, color: Colors.black, height: 48),
                                      Text("${state.meteo.getWindDirection(state.meteo.windDirection[0])} ${state.meteo.windSpeed[0]}km/h", style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                )
                            )
                        ),
                        Flexible(
                            child: Padding(padding: EdgeInsets.all(8),
                              child: Container(
                                width: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Température ressentie", style: TextStyle(fontWeight: FontWeight.bold, ), textAlign: TextAlign.center,),
                                    SvgPicture.asset(Images.direction1, color: Colors.black, height: 48,),
                                    Text("${state.meteo.temperatureRessentie[0]}°C", style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),)
                                  ],
                                ),
                              )
                            ),
                        )
                      ],
                    )
                )
              ],
            )
        );
      }
  );
}

Widget Previsions(BuildContext context){
  return BlocBuilder<VilleBloc, VilleState>(
      builder: (BuildContext context, VilleState state){
          return Padding(padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("${getWeakDay(state.datetime.weekday)}", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 20)),
                      Spacer(),
                      Container(
                        width: 32,
                        child: Text("${state.meteo.tempMinday[0].round()}°",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      SizedBox(width: 8),
                      Container(
                        width: 32,
                        child: Text("${state.meteo.tempMaxday[0].round()}°", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                    ],
                  ),
                ),

                HeureParHeure(context),

                Padding(padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("${getWeakDay(state.datetime.weekday+1)}", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 20)),
                      Spacer(),
                      SvgPicture.asset(getImageCode(state.meteo.weathercodeday[1], state.datetime, true), color: Colors.black),
                      SizedBox(width: 8,),
                      Container(
                        width: 32,
                        child: Text("${state.meteo.tempMinday[1].round()}°",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      SizedBox(width: 8),
                      Container(
                        width: 32,
                        child: Text("${state.meteo.tempMaxday[1].round()}°", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 20)),
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("${getWeakDay(state.datetime.weekday+2)}", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 20)),
                      Spacer(),
                      SvgPicture.asset(getImageCode(state.meteo.weathercodeday[2], state.datetime, true), color: Colors.black),
                      SizedBox(width: 8,),
                      Container(
                        width: 32,
                        child: Text("${state.meteo.tempMinday[2].round()}°",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      SizedBox(width: 8),
                      Container(
                        width: 32,
                        child: Text("${state.meteo.tempMaxday[2].round()}°", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 20)),
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 8, bottom: 8),
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("${getWeakDay(state.datetime.weekday+3)}", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 20)),
                      Spacer(),
                      SvgPicture.asset(getImageCode(state.meteo.weathercodeday[3], state.datetime, true), color: Colors.black),
                      SizedBox(width: 8,),
                      Container(
                        width: 32,
                        child: Text("${state.meteo.tempMinday[3].round()}°",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      SizedBox(width: 8),
                      Container(
                        width: 32,
                        child: Text("${state.meteo.tempMaxday[3].round()}°", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${getWeakDay(state.datetime.weekday+4)}", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 20)),
                        Spacer(),
                        SvgPicture.asset(getImageCode(state.meteo.weathercodeday[4], state.datetime, true), color: Colors.black),
                        SizedBox(width: 8,),
                        Container(
                          width: 32,
                          child: Text("${state.meteo.tempMinday[4].round()}°",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: 32,
                          child: Text("${state.meteo.tempMaxday[4].round()}°", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 20)),
                        )
                      ],
                    )
                ),
              ],
            ),
          );
      }
  );
}

Widget HeureParHeure(BuildContext context){
  return BlocBuilder<VilleBloc, VilleState>(
      builder: (BuildContext context, VilleState state){
        return Container(
            height: 126,
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: ListView.builder(
                itemCount: 24-state.datetime.hour,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  return index==0?
                  Card(
                      elevation: 5,
                      color: Colors.white,
                      child: SizedBox(
                          height: 110,
                          child: Padding(
                            padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${state.datetime.hour}h"),

                                SvgPicture.asset(getImageCode(state.meteo.weathercodeHourly[state.meteo.hourly.indexOf(state.datestr)], state.datetime, false), color: Colors.black, width: 32, height: 32),

                                Text("${state.meteo.temperatureHourly[state.meteo.hourly.indexOf(state.datestr)].round()}°", style: TextStyle(color: Colors.deepPurple),)
                              ],
                            ),
                          )
                      )
                  ):
                  SizedBox(
                      height: 110,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${state.datetime.hour+index}h"),

                            SvgPicture.asset(getImageCode(state.meteo.weathercodeHourly[state.meteo.hourly.indexOf(state.datestr)+1], state.datetime, false), color: Colors.black, width: 32, height: 32),

                            Text("${state.meteo.temperatureHourly[state.meteo.hourly.indexOf(state.datestr)+index].round()}°", style: TextStyle(color: Colors.deepPurple),)
                          ],
                        ),
                      )
                  );
                }
            )
        );
  });
}

Widget VilleMet(BuildContext context) {
  return BlocBuilder<VilleBloc, VilleState>(
      builder: (BuildContext context, VilleState state) {
        return Padding(
          padding: EdgeInsets.all(8),
          child: Card(
            elevation: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16, top: 16),
                              child:  Text(
                                "${getStringCode(state.meteo.weathercodeHourly[state.meteo.hourly.indexOf(state.datestr)], state.datetime)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16, top: 0),
                              child: Text(
                                "${state.meteo.TemperatureActuelle(state.datestr).round()}°",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 38,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ),

                      Padding(
                        padding: EdgeInsets.only(top: 8, right: 16),
                        child: SvgPicture.asset(
                          getImageCode(state.meteo.weathercodeHourly[state.meteo.hourly.indexOf(state.datestr)], state.datetime, false),
                          width: 64,
                          height: 64,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
                              children: [
                                TextSpan(text: "Aujourd'hui, le temps est "),
                                TextSpan(text: "${getStringCode(state.meteo.weathercodeHourly[state.meteo.hourly.indexOf(state.datestr)], state.datetime).toLowerCase()}", style: TextStyle(color: Colors.deepPurple)),
                                TextSpan(text: ". Il y aura une température minimale de "),
                                TextSpan(text: "${state.meteo.tempMinday[0].round()}°C ", style: TextStyle(color: Colors.deepPurple)),
                                TextSpan(text: "et une température maximale de "),
                                TextSpan(text: "${state.meteo.tempMaxday[0].round()}°C", style: TextStyle(color: Colors.deepPurple)),
                                TextSpan(text: ".")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
  );
}
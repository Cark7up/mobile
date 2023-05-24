import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/UI/MyApp/bloc/FlowCubit.dart';
import 'package:mobile/UI/Pages/Recherche/bloc/RechercheBloc.dart';
import 'package:mobile/UI/Pages/Recherche/bloc/RechercheEvent.dart';
import 'package:mobile/UI/Pages/Recherche/bloc/RechercheState.dart';

class Recherche extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_)=>
            RechercheBloc(flowCubit: context.read<FlowCubit>()),
        child: Scaffold(
            appBar: AppBar(
              title: Text("Ajouter une ville", style: TextStyle(fontWeight: FontWeight.bold)),
              backgroundColor: Colors.white,
            ),
            body: Column(children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocBuilder<RechercheBloc, RechercheState>(
                  builder: (BuildContext context, RechercheState state){
                    return TextFormField(
                      controller: state.search,
                      textAlign: TextAlign.justify,
                      onChanged: (value) {
                        context.read<RechercheBloc>().add(TapSearch());
                      },
                      decoration: const InputDecoration(

                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16.0)), borderSide: BorderSide.none),
                        prefixIcon: Padding(padding: EdgeInsets.only(left: 32, right: 16), child: Icon(Icons.search_outlined, color: Colors.deepPurple)),
                        contentPadding: EdgeInsets.only(right: 32, left: 32),
                        hintText: "Saisissez le nom d'une ville",
                        filled: true,
                        fillColor: Colors.black12,
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16.0)), borderSide: BorderSide.none),
                      ),
                    );
                  },
                ),
              ),

              Expanded(
                  child: Padding(padding: EdgeInsets.all(24),
                    child: BlocBuilder<RechercheBloc,RechercheState>(
                        builder: (BuildContext context, RechercheState state){
                          return (state.search.text != "" && state.cities.length == 0) ?
                          Container() //erreur aucune ville
                              : state.search.text == "" ?
                          Container() // rien
                              : ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.cities.length,
                              itemBuilder: (_, index) => GestureDetector(
                                onTap: () => context.read<FlowCubit>().showMesvilles(state.cities[index]),// Ajouter la la liste des villes avec meteo, switch sur mes villes

                                child:
                                Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                      Padding(padding: EdgeInsets.all(8),
                                          child: Text("${state.cities[index].name}, ${state.cities[index].country}", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),)
                                      ),
                                    index == state.cities.length-1 ?
                                    Container()
                                        : Container(height: 1, color: Colors.black12,)
                                      ],
                                    )
                                ),
                              )
                          );

                        }
                    ),
                  )
              ),

              /*ElevatedButton(onPressed: () { // debug button
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MesVilles(),
                    ));
              }, child: Text("text"))*/
            ],)
        )
    );
  }

}
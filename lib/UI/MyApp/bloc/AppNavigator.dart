import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/UI/MyApp/bloc/FlowCubit.dart';
import 'package:mobile/UI/MyApp/bloc/FlowState.dart';
import 'package:mobile/UI/Pages/MesVilles/view/MesVilles.dart';
import 'package:mobile/UI/Pages/Recherche/view/Recherche.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlowCubit, FlowState>(builder: ((context, state) {
      return Navigator(
        pages: [
          if (state is RechercheState) MaterialPage(child: Recherche()),
          if (state is MesVillesState) MaterialPage(child: MesVilles()),
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    }));
  }
}
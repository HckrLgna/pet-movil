import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_movil/blocs/blocs.dart';
import 'package:pets_movil/screens/screens.dart';


class CheckPermissionScreen extends StatelessWidget {
  const CheckPermissionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return state.isAllGranted
            ? const MapScreen()
            : const GpsAccesScreen();
        },
      )
    );
  }
}



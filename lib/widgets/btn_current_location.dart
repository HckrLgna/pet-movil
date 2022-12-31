
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_movil/blocs/blocs.dart';
import 'package:pets_movil/helpers/helpers.dart';


class BtnCurrentLocation extends StatelessWidget {
  
  const BtnCurrentLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only( bottom: 10 ),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 30,
        child: IconButton(
          iconSize: 35,
          icon: const Icon( Icons.my_location_outlined, color: Colors.indigo),
          onPressed: () {
            final userLocation = locationBloc.state.lastKnownLocation;
            if ( userLocation == null ) {
                final snack = CustomSnackbar( message: 'No hay ubicación' );
                ScaffoldMessenger.of(context).showSnackBar(snack);
                return;
            }       
            mapBloc.moveCamera(userLocation);
          }
        ),
      ),
    );
  }
}
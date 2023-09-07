

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_movil/blocs/blocs.dart';
import 'package:pets_movil/helpers/helpers.dart';


class ManualMarker extends StatelessWidget {
  const ManualMarker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _ManualMarkerBody();
  }
}


class _ManualMarkerBody extends StatelessWidget {

  const _ManualMarkerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;    
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return SafeArea(
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [ 
            // Boton de confirmar
            Positioned(
              top: 20,
              left: ( size.width - ( size.width - 120 ) ) / 2,
              child: FadeInUp(
                duration: const Duration( milliseconds: 300 ),
                child: MaterialButton(                
                  minWidth: size.width - 120,
                  color: Colors.indigo,
                  elevation: 0,
                  height: 50,
                  shape: const StadiumBorder(),
                  child: const Text('Confimar ubicación', style: TextStyle( color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17, letterSpacing: 3.0 )),
                  onPressed: () async {
                    final navigator = Navigator.of(context);                    
                    final center = mapBloc.mapCenter;
                    if ( center == null ) return;
                    showLoadingMessage( context );                    
                    // await mapBloc.drawRoutePolyline(destination); 
                    await mapBloc.getManualMarkerCoords( center );                                  
                    navigator.pop();
                    navigator.pop();
                  },
                ),
              )
            ),
            // Marcador manual
            Center(
              child: Transform.translate(
                offset: const Offset(0, -22 ),
                child: BounceInDown(
                  from: 100,
                  child: const Icon( Icons.location_on_rounded, size: 60, color: Colors.indigo )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


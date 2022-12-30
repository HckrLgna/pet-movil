import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pets_movil/blocs/blocs.dart';
import 'package:pets_movil/views/views.dart';
import 'package:pets_movil/widgets/widgets.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  late LocationBloc locationBloc;

  @override
  void initState() {    
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {    
    locationBloc.stopFollowingUser();
    super.dispose();
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocBuilder<LocationBloc, LocationState>( // LocationBloc
        builder: (context, locationState) {
          if ( locationState.lastKnownLocation == null ) {
            return const Center( child: Text('Espere por favor...'));
          }
          return BlocBuilder<MapBloc, MapState>( // MapBloc
            builder: (context, mapState) {
              
              Map<String, Polyline> polylines = Map.from( mapState.polylines );
              if ( !mapState.showMyRoute ) {
                polylines.removeWhere((key, value) => key == 'myRoute');
              }

              return Stack(
                children: [
                  MapView( 
                    initialLocation: locationState.lastKnownLocation!,
                    polylines: polylines.values.toSet(), 
                    markers: mapState.markers.values.toSet(),
                  ),                    
                  // const SearchBar2(), 
                  // const ManualMarker()     
                  // const BtnPlanesViaje()   
                ]  
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          if ( locationState.lastKnownLocation == null ) {
            return const SizedBox();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [          
                // BtnRecorridoMicro(),                
                // BtnPlanificadorViaje(),
                // BtnPlanesViaje(),
                BtnCurrentLocation(),
            ],
          );
        }
      )
    );
  }
}

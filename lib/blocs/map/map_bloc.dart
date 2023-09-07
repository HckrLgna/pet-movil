import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pets_movil/helpers/helpers.dart';
import 'package:pets_movil/models/models.dart';
import 'package:pets_movil/services/services.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  
  GoogleMapController? _mapController;  
  LatLng? mapCenter;   
  final PlacesService _placesService = PlacesService();
  
  
  MapBloc() : super( const MapState() ) {
    on<OnMapInitialzedEvent>( _onInitMap );    
    on<DisplayPolylinesEvent>((event, emit) => emit( state.copyWith( polylines: event.polylines, markers: event.markers ) ));
    on<OnSetAddressEvent>((event, emit) => emit( state.copyWith( address: event.address ) ));
    on<OnShowMarkers>((event, emit) => emit( state.copyWith( isMarkersDisplayed: true ) ));
    on<OnHideMarkers>((event, emit) => emit( state.copyWith( isMarkersDisplayed: false, polylines: {}, markers: {} ) ));
    on<OnUnsetAddressEvent>((event, emit) => emit( state.copyWith( address: 'Ubicación de la mascota' ) ));        
  } 

  void _onInitMap( OnMapInitialzedEvent event, Emitter<MapState> emit ) {
    _mapController = event.controller;    
    emit( state.copyWith( isMapInitialized: true ) );    
  } 

  Future showMarcadores() async {
    // -17.833278202048852, -63.18304726803052
    // -17.834101498711693, -63.18637012544121
    LatLng start = const LatLng(-17.833278202048852, -63.18304726803052);
    // LatLng end = const LatLng(-17.834101498711693, -63.18637012544121);

    final startMaker = await getAssetImageMarker('assets/encontrado1.png');
    final endMaker = await getAssetImageMarker('assets/perdido1.png');

    final startMarker = Marker(
      // anchor: const Offset(0.1, 1),
      markerId: const MarkerId('start'),
      position: start,
      icon: startMaker,
      infoWindow: const InfoWindow(
        title: 'ENCONTRADO',
        snippet: 'Una mascota se encontro en esta ubicación' 
      )          
    );

    // final endMarker = Marker(
    //   markerId: const MarkerId('end'),
    //   position: end,
    //   icon: endMaker,infoWindow: const InfoWindow(
    //     title: 'PERDIDO',
    //     snippet: 'Una mascota se perdio en esta ubicación' 
    //   )                   
    // );
  
    final currentMarkers = Map<String, Marker>.from( state.markers );
    currentMarkers['start'] = startMarker;
    // currentMarkers['end'] = endMarker;
    add( DisplayPolylinesEvent( const {}, currentMarkers ) );      
    
  }  

  Future drawRoutePolyline( RouteDestination destination ) async {
    final myRoute = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.black,
      width: 5,
      points: destination.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,      
    );   

    // final startMaker = await getAssetImageMarker();
    // final endMaker = await getNetworkImageMarker();    

    final startMarker = Marker(
      anchor: const Offset(0.1, 1),
      markerId: const MarkerId('start'),
      position: destination.points.first,      
    );

    final endMarker = Marker(
      markerId: const MarkerId('end'),
      position: destination.points.last,
      // icon: endMaker,
      // infoWindow: InfoWindow(
      //   title: destination.endPlace.text,
      //   snippet: destination.endPlace.placeName,
      // )
    );

    final currentPolylines = Map<String, Polyline>.from( state.polylines );
    currentPolylines['route'] = myRoute;
    final currentMarkers = Map<String, Marker>.from( state.markers );
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;
    add( DisplayPolylinesEvent( currentPolylines, currentMarkers ) );

    // await Future.delayed( const Duration( milliseconds: 300 ));
    // _mapController?.showMarkerInfoWindow(const MarkerId('start'));    
  }

  Future<void> getManualMarkerCoords( LatLng position ) async {
    Feature place = await _placesService.getInformationByCoors( position );
    add( OnSetAddressEvent( place.text ) );
  }

  void moveCamera( LatLng newLocation ) {
    final cameraUpdate = CameraUpdate.newLatLng( newLocation );
    _mapController?.animateCamera(cameraUpdate);
  }
  
  @override
  Future<void> close() {
    // locationStateSubscription?.cancel();
    return super.close();
  }

}

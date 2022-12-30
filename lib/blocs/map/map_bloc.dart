import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pets_movil/blocs/blocs.dart';
import 'package:pets_movil/models/models.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  final LocationBloc locationBloc;
  GoogleMapController? _mapController;  
  LatLng? mapCenter;
  
  
  MapBloc({
    required this.locationBloc,    
  }) : super( const MapState() ) {
    on<OnMapInitialzedEvent>( _onInitMap );    
    on<DisplayPolylinesEvent>((event, emit) => emit( state.copyWith( polylines: event.polylines, markers: event.markers ) ));    
  }  

  Future showMarcadores( LatLng start, LatLng end ) async {

    // final startMaker = await getAssetImageMarker('assets/pin-green4.png');
    // final endMaker = await getAssetImageMarker('assets/flag-red.png');
    final startMarker = Marker(
      // anchor: const Offset(0.1, 1),
      markerId: const MarkerId('start'),
      position: start,          
    );

    final endMarker = Marker(
      markerId: const MarkerId('end'),
      position: end,                  
    );
  
    final currentMarkers = Map<String, Marker>.from( state.markers );
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;
    add( DisplayPolylinesEvent( const {}, currentMarkers ) );      
      
  }
  

  void _onInitMap( OnMapInitialzedEvent event, Emitter<MapState> emit ) {
    _mapController = event.controller;    
    emit( state.copyWith( isMapInitialized: true ) );    
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

    double kms = destination.distance / 1000;
    kms = (kms * 100).floorToDouble();
    kms /= 100;

    int tripDuration = (destination.duration / 60).floorToDouble().toInt();

    // final startMaker = await getAssetImageMarker();
    // final endMaker = await getNetworkImageMarker();
    // final startMaker = await getStartCustomMarker( tripDuration, 'Mi ubicación' );
    // final endMaker = await getEndCustomMarker( kms.toInt(), destination.endPlace.text );

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

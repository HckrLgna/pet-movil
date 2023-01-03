part of 'map_bloc.dart';

class MapState extends Equatable {

  final bool isMapInitialized;
  final bool isMarkersDisplayed;
  final String address;
  // Polylines
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers; 

  const MapState({
    this.isMapInitialized = false,
    this.address = 'Ubicación de la mascota',
    this.isMarkersDisplayed = false,         
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  }): polylines = polylines ?? const {},
      markers = markers ?? const {};

  MapState copyWith({
    bool? isMapInitialized,       
    String? address,
    bool? isMarkersDisplayed, 
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  }) => MapState(
    isMapInitialized : isMapInitialized ?? this.isMapInitialized, 
    address: address ?? this.address,
    isMarkersDisplayed: isMarkersDisplayed ?? this.isMarkersDisplayed,    
    polylines: polylines ?? this.polylines,
    markers: markers ?? this.markers,
  );
  @override
  List<Object> get props => [ isMapInitialized, address, isMarkersDisplayed, polylines, markers ];
}



part of 'map_bloc.dart';

class MapState extends Equatable {

  final bool isMapInitialized; 

  // Polylines
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers; 

  const MapState({
    this.isMapInitialized = false,       
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  }): polylines = polylines ?? const {},
      markers = markers ?? const {};

  MapState copyWith({
    bool? isMapInitialized,       
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  }) => MapState(
    isMapInitialized : isMapInitialized ?? this.isMapInitialized,    
    polylines: polylines ?? this.polylines,
    markers: markers ?? this.markers,
  );
  @override
  List<Object?> get props => [ isMapInitialized, polylines, markers ];
}



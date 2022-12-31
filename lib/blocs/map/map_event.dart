part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitialzedEvent extends MapEvent {
  final GoogleMapController controller;
  const OnMapInitialzedEvent(this.controller);
}

class OnSetAddressEvent extends MapEvent {
  final String address;
  const OnSetAddressEvent( this.address );
}
class OnUnsetAddressEvent extends MapEvent {}

class DisplayPolylinesEvent extends MapEvent {
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;
  const DisplayPolylinesEvent(this.polylines, this.markers);
}
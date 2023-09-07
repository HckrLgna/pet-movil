import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:pets_movil/models/models.dart';
import 'package:pets_movil/services/places_intercerptor.dart';



class PlacesService {    
  final Dio _dioPlaces;
  final String _basePlacesUrl  = 'https://api.mapbox.com/geocoding/v5/mapbox.places';

  PlacesService() : _dioPlaces = Dio()..interceptors.add( PlacesInterceptor() );
  
  Future<Feature> getInformationByCoors( LatLng coors ) async {
    final url = '$_basePlacesUrl/${ coors.longitude },${ coors.latitude }.json';
    final resp = await _dioPlaces.get(url, queryParameters: {
      'limit': 1
    });
    final placesResponse = PlacesResponse.fromMap(resp.data);    
    return placesResponse.features[0];
  }

}
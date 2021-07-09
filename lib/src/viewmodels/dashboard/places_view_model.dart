import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places/src/core/base_view_model.dart';
import 'package:places/src/services/dashboard/places_service.dart';

class PlacesViewModel extends BaseViewModel {
  final PlacesService service;

  PlacesViewModel({required this.service});

  String? _imagePath;
  String? get imagePath => _imagePath;

  void setImage(String path){
    _imagePath = path;
    notifyListeners();
  }
  LatLng? _location;
  LatLng? get location => _location;

  void setLocation(LatLng loc){
    _location = loc;
    notifyListeners();
  }
}

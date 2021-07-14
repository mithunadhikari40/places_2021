import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places/src/core/base_view_model.dart';
import 'package:places/src/model/dashboard/place_model.dart';
import 'package:places/src/model/network_response_model.dart';
import 'package:places/src/services/dashboard/explore_service.dart';
import 'package:places/src/services/dashboard/places_service.dart';

class PlacesViewModel extends BaseViewModel {
  final PlacesService service;

  final ExploreService exploreService;

  PlacesViewModel({required this.service, required this.exploreService});

  String? _imagePath;

  String? get imagePath => _imagePath;

  void setImage(String path) {
    _imagePath = path;
    notifyListeners();
  }

  LatLng? _location;

  LatLng? get location => _location;

  void setLocation(LatLng loc) {
    _location = loc;
    notifyListeners();
  }

  void setInitialLocation() {
    _location = currentLocation;
  }

  bool _useCurrentLocation = true;

  bool get useCurrentLocation => _useCurrentLocation;

  LatLng get currentLocation => LatLng(
      service.currentLocation.latitude!, service.currentLocation.longitude!);

  void setLocationMethod(bool val) {
    //if true  --- current location being used
    _useCurrentLocation = val;
    if (val) {
      _location = LatLng(service.currentLocation.latitude!,
          service.currentLocation.longitude!);
    }
    notifyListeners();
  }

  Future<NetworkResponseModel> postData({
    required String name,
    required String monument,
    required String description,
    required String city,
    required String address,
    required String street,
  }) async {
    setBusy(true);
    var response = await service.addNewPlace(
        name: name,
        city: city,
        street: street,
        monument: monument,
        address: address,
        latitude: _location!.latitude,
        longitude: _location!.longitude,
        description: description,
        imagePath: _imagePath!);
    if (response.status) {
      final PlaceModel place = response.data as PlaceModel;
      exploreService.addNewPlace(place);
    }
    setBusy(false);
    return response;
  }
}

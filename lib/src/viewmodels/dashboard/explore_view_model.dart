import 'package:location/location.dart';
import 'package:places/src/core/base_view_model.dart';
import 'package:places/src/model/dashboard/place_model.dart';
import 'package:places/src/model/network_response_model.dart';
import 'package:places/src/services/dashboard/explore_service.dart';

class ExploreViewModel extends BaseViewModel {
  final ExploreService service;

  ExploreViewModel({required this.service});

  LocationData? get currentLocation => service.currentLocation;

  NetworkResponseModel get places => service.places;


  Stream<List<PlaceModel>> get placeStream => service.placeStream;



  Future<void> initialize() async {
    setBusy(true);
    await service.getAllPlaces();
    await Future.delayed(Duration(milliseconds: 500));
    setBusy(false);
  }

  bool _adLoaded = false;

  bool get adLoaded => _adLoaded;

  void setAdLoaded(bool val) {
    _adLoaded = val;
    notifyListeners();
  }
}

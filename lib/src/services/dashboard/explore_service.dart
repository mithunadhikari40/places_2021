import 'dart:async';

import 'package:location/location.dart';
import 'package:places/src/api/dashboard/explore_api.dart';
import 'package:places/src/model/dashboard/place_model.dart';
import 'package:places/src/model/network_response_model.dart';
import 'package:places/src/services/auth_rx_provider.dart';
import 'package:rxdart/rxdart.dart';

class ExploreService {
  final ExploreApi api;
  final AuthRxProvider authRxProvider;

  ExploreService({required this.api, required this.authRxProvider});

  NetworkResponseModel? _places = NetworkResponseModel(status: true,data: []);

  NetworkResponseModel get places => _places!;

 final BehaviorSubject<List<PlaceModel>> _placesController = BehaviorSubject();
  Stream<List<PlaceModel>> get placeStream => _placesController.stream;

  void jjj(){
    _placesController.close();
  }

  LocationData? get currentLocation => authRxProvider.getLocation;

  Future<void> getAllPlaces() async {
    final response = await api.getAllPlaces();
    // if(response.status){
    //   //to something
    //   String value  = response.data;
    // }
    _places = response;
    print("Is this place model null ${_places == null} and ${places.status}");

    if(_places!.status){
      List<PlaceModel> list = _places!.data!.cast<PlaceModel>();
      print("The list is this one ${list.map((e) => e.toJson())}");
      _placesController.sink.add(list);

    }
    await Future.delayed(Duration.zero);
  }

  void addNewPlace(PlaceModel place){
    print("This place response is this one ${place.toJson()}");
    List<PlaceModel> _existing = _placesController.value;
    _existing.add(place);
    _places!.data = _existing;
    _placesController.sink.add(_existing);
    print("This place response is this one ${_existing.map((e) => e.name)}");
    print("This place response is this one ${_existing.map((e) => e.sId)}");


  }
}

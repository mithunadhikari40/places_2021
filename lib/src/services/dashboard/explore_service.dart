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

  NetworkResponseModel _places = NetworkResponseModel(status: true,data: []);

  NetworkResponseModel get places => _places;

  BehaviorSubject<List<PlaceModel>> _placeSubject = BehaviorSubject();
  Stream<List<PlaceModel>> get placeStream => _placeSubject.stream;


  void closeStream(){
    _placeSubject.close();
  }



  LocationData? get currentLocation => authRxProvider.getLocation;

  Future<void> getAllPlaces() async {
    final response = await api.getAllPlaces();
    // if(response.status){
    //   //to something
    //   String value  = response.data;
    // }
    _places = response;
    if(_places.status){
      List<PlaceModel> existingList = _places.data.cast<PlaceModel>();
      _placeSubject.sink.add(existingList);

    }
    await Future.delayed(Duration.zero);
  }

  void addNewPlace(PlaceModel place){
    List<PlaceModel> existing = _placeSubject.value;
    existing.add(place);
    _placeSubject.sink.add(existing);
    _places.data = existing;
    print("the places are ${existing.map((e) => e.name)}");
  }



}

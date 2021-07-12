import 'package:location/location.dart';
import 'package:places/src/api/dashboard/favorite_api.dart';
import 'package:places/src/model/dashboard/place_model.dart';
import 'package:places/src/model/network_response_model.dart';
import 'package:places/src/services/auth_rx_provider.dart';

class FavoriteService {
  final FavoriteApi api;
  final AuthRxProvider authRxProvider;

  FavoriteService({required this.api, required this.authRxProvider});

  NetworkResponseModel? _places;

  NetworkResponseModel get places => _places!;

  LocationData? get currentLocation => authRxProvider.getLocation;

  Future<void> getAllPlaces() async {
    final response = await api.getAllPlaces();
    _places = response;
  }

  void removeItem(int index) {
    List<PlaceModel> list = _places!.data!.cast<PlaceModel>();
    list.removeAt(index);
    _places!.data = list;
  }

  Future<void> removeFromApi(int index, PlaceModel place) async {
    final response = await api.addOrRemoveFromFavorite(place.sId!);
    if (!response.status) {
      List<PlaceModel> list = _places!.data!.cast<PlaceModel>();
      list.insert(index, place);
      _places!.data = list;
    }
  }

  Future<NetworkResponseModel> addOrRemoveFromFavorite(String id) async {
    final response = await api.addOrRemoveFromFavorite(id);
   return response;
  }

  Future<NetworkResponseModel> isFavorite(String id) async {
    final response = await api.isFavorite(id);
    return response;
  }

}

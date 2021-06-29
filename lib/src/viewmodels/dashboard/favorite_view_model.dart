import 'package:location/location.dart';
import 'package:places/src/core/base_view_model.dart';
import 'package:places/src/model/dashboard/place_model.dart';
import 'package:places/src/model/network_response_model.dart';
import 'package:places/src/services/dashboard/favorite_service.dart';

class FavoriteViewModel extends BaseViewModel {
  final FavoriteService service;

  FavoriteViewModel({required this.service});

  LocationData? get currentLocation => service.currentLocation;

  NetworkResponseModel get favorites => service.favorites;

  Future<void> initialize() async {
    setBusy(true);
    await service.getAllFavorites();
    setBusy(false);
  }

  Future<void> removeItemFromFavorite(PlaceModel place) async {
    final int index = service.favorites.data.cast<PlaceModel>().indexWhere((element) => element.sId == place.sId);
   service.removeItem(place);
    notifyListeners();
    await service.removeItemFromApi(place,index);
    notifyListeners();
  }
}

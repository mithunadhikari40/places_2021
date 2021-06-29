import 'package:location/location.dart';
import 'package:places/src/api/dashboard/favorite_api.dart';
import 'package:places/src/model/dashboard/place_model.dart';
import 'package:places/src/model/network_response_model.dart';
import 'package:places/src/services/auth_rx_provider.dart';

class FavoriteService {
  final FavoriteApi api;
  final AuthRxProvider authRxProvider;

  FavoriteService({required this.api, required this.authRxProvider});

  NetworkResponseModel? _favorites;

  NetworkResponseModel get favorites => _favorites!;

  LocationData? get currentLocation => authRxProvider.getLocation;

  Future<void> getAllFavorites() async {
    final String token = authRxProvider.getToken!;
    final response = await api.getAllFavorites(token);
    _favorites = response;
  }

  void removeItem(PlaceModel place) {
    List<PlaceModel> list = _favorites!.data.cast<PlaceModel>();
    list.removeWhere((element) => element.sId == place.sId);
    _favorites!.data = list;
  }

  Future<void> removeItemFromApi(PlaceModel place, int index) async {
    final String token = authRxProvider.getToken!;

    final response = await api.removeFromFavorite(token, place.sId!);
    if (!response.status) {
      return;
    }

    List<PlaceModel> list = _favorites!.data.cast<PlaceModel>();
    list.insert(index, place);
    _favorites!.data = list;
  }
}

import 'dart:convert';

import 'package:http/http.dart';
import 'package:places/src/core/constants/app_url.dart';
import 'package:places/src/model/dashboard/place_model.dart';
import 'package:places/src/model/network_response_model.dart';

class FavoriteApi {
  Future<NetworkResponseModel> getAllFavorites(String token) async {
    try {
      final uri = Uri.parse(AppUrl.FAVORITE_LIST_URL);
      final response = await get(
        uri,
        headers: {"Content-Type": "application/json", "x-auth-token": token},
      );
      final body = jsonDecode(response.body);
      print("list of favorite $body");
      if(body["places"] == null){
        return NetworkResponseModel(status: true, data: []);
      }
      final list = PlaceModel.allResponse(body["places"]);
      return NetworkResponseModel(status: true, data: list);
    } catch (e) {
      print("The favorite exception $e");
      return NetworkResponseModel(
          status: false, message: "$e".replaceAll("Exception:", ""));
    }
  }
  Future<NetworkResponseModel> removeFromFavorite(String token,String placeId) async {
    try {
      final uri = Uri.parse(AppUrl.FAVORITE_LIST_URL);
      final response = await put(
        uri,
        body: jsonEncode({"id":placeId}),
        headers: {"Content-Type": "application/json", "x-auth-token": token},
      );
      final body = jsonDecode(response.body);
      print("put of favorite $body");
      if(body["places"] == null){
        return NetworkResponseModel(status: true, data: []);
      }        return NetworkResponseModel(status: false, data: []);


    } catch (e) {
      print("The favorite exception $e");
      return NetworkResponseModel(
          status: false, message: "$e".replaceAll("Exception:", ""));
    }
  }
}

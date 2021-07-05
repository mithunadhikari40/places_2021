import 'dart:convert';

import 'package:http/http.dart';
import 'package:places/src/core/constants/app_url.dart';
import 'package:places/src/model/dashboard/place_model.dart';
import 'package:places/src/model/network_response_model.dart';
import 'package:places/src/model/user_model.dart';

class ProfileApi {
  Future<NetworkResponseModel> updateName(String name,String token) async {
    try {
      final uri = Uri.parse(AppUrl.UPDATE_NAME_URL);
      final response = await put(uri,
        body: jsonEncode({
          "name":name
        }),
        headers: {
          "Content-Type": "application/json",
          "x-auth-token":token
        },

      );
      final body = jsonDecode(response.body);
      print("update name response $body");
      final user = UserModel.fromJson(body["data"]);
      return NetworkResponseModel(status: true, data: user);
    } catch (e) {
      print("The update name  exception $e");
      return NetworkResponseModel(
          status: false, message: "$e".replaceAll("Exception:", ""));
    }
  }
}

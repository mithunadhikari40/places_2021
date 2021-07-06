import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:places/src/core/constants/app_url.dart';
import 'package:places/src/model/network_response_model.dart';
import 'package:places/src/model/user_model.dart';

class ProfileApi {
  Future<NetworkResponseModel> updateName(String name, String token) async {
    try {
      final uri = Uri.parse(AppUrl.UPDATE_NAME_URL);
      final response = await put(
        uri,
        body: jsonEncode({"name": name}),
        headers: {"Content-Type": "application/json", "x-auth-token": token},
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

  Future<NetworkResponseModel> updatePassword(
      String password, String token) async {
    try {
      final uri = Uri.parse(AppUrl.UPDATE_PASSWORD_URL);
      final response = await put(
        uri,
        body: jsonEncode({"password": password}),
        headers: {"Content-Type": "application/json", "x-auth-token": token},
      );
      final body = jsonDecode(response.body);

      print("update password response $body");
      if (body["token"] == null) {
        return NetworkResponseModel(status: false, data: body["error"]);
      }
      final data = body["token"];
      return NetworkResponseModel(status: true, data: data);
    } catch (e) {
      print("The update password  exception $e");
      return NetworkResponseModel(
          status: false, message: "$e".replaceAll("Exception:", ""));
    }
  }

  Future<NetworkResponseModel> updateProfilePic(
      String imagePath, String token) async {
    try {
      final uri = Uri.parse(AppUrl.UPDATE_PROFILE_PIC_URL);

      MultipartRequest request = MultipartRequest('PUT', uri);

      // request.fields.addAll({
      //   "name":"Bishnu Bhusal",
      //   "age":"33",
      //   "address":"Temp Address",
      // });

      request.headers.addAll(
          {"content-type": "multipart/form-data", "x-auth-token": token});

      final imageBody = await MultipartFile.fromPath(
        "image",
        imagePath,
        contentType: MediaType("image","jpg")
      );
      request.files.add(imageBody);
      final streamedResponse = await request.send();
      final response = await Response.fromStream(streamedResponse);

      final body = jsonDecode(response.body);
      print("update name response $body");
      final user = UserModel.fromJson(body["data"]);
      return NetworkResponseModel(status: true, data: user);

    } catch (e) {
      print("The update profile pic  exception $e");
      return NetworkResponseModel(
          status: false, message: "$e".replaceAll("Exception:", ""));
    }
  }
}

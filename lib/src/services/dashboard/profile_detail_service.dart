import 'package:places/src/api/dashboard/profile_api.dart';
import 'package:places/src/core/constants/app_constants.dart';
import 'package:places/src/model/network_response_model.dart';
import 'package:places/src/model/user_model.dart';
import 'package:places/src/services/auth_rx_provider.dart';
import 'package:places/src/services/local/cache_provider.dart';
import 'package:places/src/services/local/db_provider.dart';

class ProfileDetailService {
  final AuthRxProvider authRxProvider;
  final DbProvider dbProvider;
  final CacheProvider cacheProvider;
  final ProfileApi api;

  ProfileDetailService(
      {required this.authRxProvider,
      required this.cacheProvider,
      required this.api,
      required this.dbProvider});

  UserModel get currentUser => authRxProvider.getUser!;

  Future<bool> logout() async {
    // call an api to clear out the session data, or some other info
    await dbProvider.clear();
    await cacheProvider.clear();
    authRxProvider.clear();
    return true;
  }

  Future<NetworkResponseModel> updateName(String newName) async {
    final response = await api.updateName(newName);
    if (response.status) {
      final user = authRxProvider.getUser!;
      user.name = newName;
      authRxProvider.addUser(user);
      await dbProvider.updateName(user.sId!, user);
    }
    return response;
  }

  Future<NetworkResponseModel> updateProfilePic(String imagePth, String url) async {
    final response = await api.updateProfilePic(imagePth,url);
    if (response.status) {
      // final user = authRxProvider.getUser!;
      UserModel newUser = response.data!;
      // user.profilePic = newUser.profilePic!;
      authRxProvider.addUser(newUser);
      await dbProvider.updateName(newUser.sId!, newUser);
    }
    return response;
  }

  Future<NetworkResponseModel> updatePassword(String newPassword) async {
    final response = await api.updatePassword(newPassword);
    if (response.status) {
      authRxProvider.addToken(response.data!);
      await cacheProvider.setStringValue(TOKEN_KEY, response.data!);
    }
    return response;
  }
}

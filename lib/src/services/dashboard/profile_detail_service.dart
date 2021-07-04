import 'package:places/src/model/user_model.dart';
import 'package:places/src/services/auth_rx_provider.dart';
import 'package:places/src/services/local/cache_provider.dart';
import 'package:places/src/services/local/db_provider.dart';

class ProfileDetailService {
  final AuthRxProvider authRxProvider;
  final DbProvider dbProvider;
  final CacheProvider cacheProvider;

  ProfileDetailService(
      {required this.authRxProvider,
      required this.cacheProvider,
      required this.dbProvider});

  UserModel get currentUser => authRxProvider.getUser!;
  Future<bool> logout() async {
    // call an api to clear out the session data, or some other info
    await dbProvider.clear();
    await cacheProvider.clear();
    authRxProvider.clear();
    return true;

  }
}

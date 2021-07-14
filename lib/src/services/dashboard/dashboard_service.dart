import 'package:location/location.dart';
import 'package:places/src/api/dashboard/profile_api.dart';
import 'package:places/src/core/constants/app_constants.dart';
import 'package:places/src/services/auth_rx_provider.dart';
import 'package:places/src/services/local/cache_provider.dart';
import 'package:places/src/services/local/db_provider.dart';
import 'package:places/src/services/theme_service.dart';

class DashboardService {
  final AuthRxProvider authRxProvider;
  final ProfileApi api;
  final CacheProvider cache;
  final DbProvider dbProvider;

  DashboardService(
      {required this.authRxProvider, required this.api, required this.cache, required this.dbProvider});

  void setLocation(LocationData locationData) {
    authRxProvider.addLocation(locationData);
  }

  void updateToken(String token) {
    api.updateToken(token);
  }

  void changeTheme() {
    bool currentTheme = themeService.getTheme;
    cache.setBoolValue(THEME_KEY, !currentTheme);
    themeService.addTheme(!currentTheme);
  }
  Future<bool> logout() async {
    // call an api to clear out the session data, or some other info
    await dbProvider.clear();
    await cache.clear();
    authRxProvider.clear();
    return true;
  }
}

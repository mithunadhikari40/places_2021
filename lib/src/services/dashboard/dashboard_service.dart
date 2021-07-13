import 'package:location/location.dart';
import 'package:places/src/api/auth_api.dart';
import 'package:places/src/api/dashboard/profile_api.dart';
import 'package:places/src/services/auth_rx_provider.dart';

class DashboardService {
  final AuthRxProvider authRxProvider;
  final ProfileApi api;

  DashboardService({required this.authRxProvider,required this.api});

  void setLocation(LocationData locationData) {
    authRxProvider.addLocation(locationData);
  }

  void updateToken(String token) {
    api.updateToken(token);
  }
}

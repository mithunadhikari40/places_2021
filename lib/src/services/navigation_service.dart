import 'package:flutter/material.dart';
import 'package:places/src/core/constants/route_paths.dart';
import 'package:places/src/services/local/cache_provider.dart';
import 'package:places/src/services/local/db_provider.dart';
import 'package:provider/provider.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> logout() {
    final db = Provider.of<DbProvider>(navigatorKey.currentContext!,listen: false);
    db.clear();final cache = Provider.of<CacheProvider>(navigatorKey.currentContext!,listen: false);
    cache.clear();
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(RoutePaths.LOGIN,
        (Route route) {
      return route.settings.name == RoutePaths.LOGIN;
    });
  }
}

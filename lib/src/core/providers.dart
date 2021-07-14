import 'package:flutter/cupertino.dart';
import 'package:places/src/api/auth_api.dart';
import 'package:places/src/api/dashboard/explore_api.dart';
import 'package:places/src/api/dashboard/favorite_api.dart';
import 'package:places/src/api/dashboard/my_places_api.dart';
import 'package:places/src/api/dashboard/places_api.dart';
import 'package:places/src/api/dashboard/profile_api.dart';
import 'package:places/src/services/auth/auth_service.dart';
import 'package:places/src/services/auth_rx_provider.dart';
import 'package:places/src/services/dashboard/dashboard_service.dart';
import 'package:places/src/services/dashboard/explore_service.dart';
import 'package:places/src/services/dashboard/favorite_service.dart';
import 'package:places/src/services/dashboard/my_place_service.dart';
import 'package:places/src/services/dashboard/places_service.dart';
import 'package:places/src/services/dashboard/profile_detail_service.dart';
import 'package:places/src/services/local/cache_provider.dart';
import 'package:places/src/services/local/db_provider.dart';
import 'package:places/src/services/splash_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ...independentProviders,
  ...dependantProviders,
];

final List<SingleChildWidget> independentProviders = [
  Provider.value(value: AuthApi()),
  Provider.value(value: MyPlacesApi()),
  Provider.value(value: PlaceApi()),
  Provider.value(value: ExploreApi()),
  Provider.value(value: FavoriteApi()),
  Provider.value(value: DbProvider()),
  Provider.value(value: ProfileApi()),
  Provider.value(value: CacheProvider()),
  Provider.value(value: AuthRxProvider()),
];
final List<SingleChildWidget> dependantProviders = [
  ProxyProvider3<DbProvider, CacheProvider, AuthRxProvider, SplashService>(
    update: (BuildContext context,
        DbProvider dbProvider,
        CacheProvider cacheProvider,
        AuthRxProvider authRxProvider,
        SplashService? service) {
      return service ??
          SplashService(
              authRxProvider: authRxProvider,
              cacheProvider: cacheProvider,
              dbProvider: dbProvider);
    },
  ),
  ProxyProvider4<DbProvider, CacheProvider, AuthRxProvider, ProfileApi,
      ProfileDetailService>(
    update: (BuildContext context,
        DbProvider dbProvider,
        CacheProvider cacheProvider,
        AuthRxProvider authRxProvider,
        ProfileApi api,
        ProfileDetailService? service) {
      return service ??
          ProfileDetailService(
              authRxProvider: authRxProvider,
              api: api,
              cacheProvider: cacheProvider,
              dbProvider: dbProvider);
    },
  ),
  ProxyProvider4<AuthApi, DbProvider, CacheProvider, AuthRxProvider,
      AuthService>(
    update: (BuildContext context,
        AuthApi api,
        DbProvider dbProvider,
        CacheProvider cacheProvider,
        AuthRxProvider authRxProvider,
        AuthService? service) {
      return service ??
          AuthService(
              api: api,
              authRxProvider: authRxProvider,
              cacheProvider: cacheProvider,
              dbProvider: dbProvider);
    },
  ),
  ProxyProvider4<AuthRxProvider, ProfileApi, CacheProvider, DbProvider,DashboardService>(
    update: (BuildContext context, AuthRxProvider authRxProvider,
        ProfileApi api, CacheProvider cache, DbProvider dbProvider, DashboardService? service) {
      return service ??
          DashboardService(
              authRxProvider: authRxProvider, api: api, cache: cache, dbProvider: dbProvider);
    },
  ),
  ProxyProvider2<PlaceApi, AuthRxProvider, PlacesService>(
    update: (BuildContext context, PlaceApi api, AuthRxProvider authRxProvider,
        PlacesService? service) {
      return service ?? PlacesService(api: api, authRxProvider: authRxProvider);
    },
  ),
  ProxyProvider2<ExploreApi, AuthRxProvider, ExploreService>(
    update: (BuildContext context, ExploreApi api,
        AuthRxProvider authRxProvider, ExploreService? service) {
      return service ??
          ExploreService(api: api, authRxProvider: authRxProvider);
    },
  ),
  ProxyProvider2<FavoriteApi, AuthRxProvider, FavoriteService>(
    update: (BuildContext context, FavoriteApi api,
        AuthRxProvider authRxProvider, FavoriteService? service) {
      return service ??
          FavoriteService(api: api, authRxProvider: authRxProvider);
    },
  ),
  ProxyProvider2<MyPlacesApi, AuthRxProvider, MyPlacesService>(
    update: (BuildContext context, MyPlacesApi api,
        AuthRxProvider authRxProvider, MyPlacesService? service) {
      return service ??
          MyPlacesService(api: api, authRxProvider: authRxProvider);
    },
  ),
];

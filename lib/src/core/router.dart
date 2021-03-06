import 'package:flutter/material.dart';
import 'package:places/src/core/constants/route_paths.dart';
import 'package:places/src/model/dashboard/place_model.dart';
import 'package:places/src/screens/auth/login_screen.dart';
import 'package:places/src/screens/auth/signup_screen.dart';
import 'package:places/src/screens/dashboard/add_new_place_screen.dart';
import 'package:places/src/screens/dashboard/dashboard_screen.dart';
import 'package:places/src/screens/dashboard/place_detail_view.dart';
import 'package:places/src/screens/dashboard/privacy_policy_screen.dart';
import 'package:places/src/screens/dashboard/splash_screen.dart';
import 'package:places/src/screens/dashboard/terms_and_condition_screen.dart';

class Router {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.SPLASH:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case RoutePaths.LOGIN:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case RoutePaths.REGISTER:
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      case RoutePaths.HOME:
        return MaterialPageRoute(builder: (context) => DashboardScreen());
      case RoutePaths.ADD_NEW:
        return MaterialPageRoute(builder: (context) => AddNewPlaceScreen());
      case RoutePaths.VIEW_DETAIL:
        final place = settings.arguments as PlaceModel;
        return MaterialPageRoute(
            builder: (context) => PlaceDetailView(
                  place: place,
                ));

      case RoutePaths.PRIVACY_POLICY:
        return MaterialPageRoute(builder: (context) => PrivacyPolicyScreen());
      case RoutePaths.TERMS_CONDITION:
        return MaterialPageRoute(
            builder: (context) => TermsAndConditionsScreen());
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text("No route defined for ${settings.name}"),
            ),
          ),
        );
    }
  }
}

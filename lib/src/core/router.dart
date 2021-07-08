import 'package:flutter/material.dart';
import 'package:places/src/core/constants/route_paths.dart';
import 'package:places/src/screens/auth/login_screen.dart';
import 'package:places/src/screens/auth/signup_screen.dart';
import 'package:places/src/screens/dashboard/dashboard_screen.dart';
import 'package:places/src/screens/dashboard/splash_screen.dart';

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

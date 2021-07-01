import 'package:flutter/material.dart';
import 'package:places/src/core/providers.dart';
import 'package:places/src/screens/dashboard/splash_screen.dart';
import 'package:places/src/widgets/shared/app_colors.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: "Places",
        theme: ThemeData(
          primaryColor: whiteColor
        ),

        home: SplashScreen(),
      ),
    );
  }
}

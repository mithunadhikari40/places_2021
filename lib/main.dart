import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:places/src/core/constants/route_paths.dart';
import 'package:places/src/core/locator.dart';
import 'package:places/src/core/providers.dart';
import 'package:places/src/core/router.dart';
import 'package:places/src/services/navigation_service.dart';
import 'package:places/src/services/theme_service.dart';
import 'package:places/src/widgets/shared/app_colors.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  setupLocator();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: StreamBuilder(
          stream: themeService.themeStream,
          builder: (context, AsyncSnapshot<bool> snapshot) {
            bool _dark = snapshot.hasData && snapshot.data!;
            if (snapshot.hasData) {
              _dark = snapshot.data!;
            }
            return MaterialApp(
              title: "Places",
              navigatorKey: locator<NavigationService>().navigatorKey,
              themeMode: _dark ? ThemeMode.dark : ThemeMode.light,
              theme: ThemeData(
                primaryColor: whiteColor,
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide.none),
                  padding: EdgeInsets.all(18.0),
                  primary: primaryColor,
                )),
                textTheme: Theme.of(context).textTheme.apply(
                      bodyColor: blackColor,
                      displayColor: blackColor,
                    ),
                buttonColor: primaryColor,
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(primary: primaryColor)),
                outlinedButtonTheme: OutlinedButtonThemeData(
                    style: OutlinedButton.styleFrom(primary: primaryColor)),
                buttonTheme: ButtonThemeData(
                  buttonColor: primaryColor,
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: primaryColor,
                ),
                iconTheme:
                    Theme.of(context).iconTheme.copyWith(color: primaryColor),
                primaryIconTheme:
                    Theme.of(context).iconTheme.copyWith(color: primaryColor),
              ),
              darkTheme: ThemeData(
                primaryColor: whiteColor,
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide.none),
                  padding: EdgeInsets.all(18.0),
                  primary: cyanColor,
                )),
                textTheme: Theme.of(context).textTheme.apply(
                      bodyColor: blackColor,
                      displayColor: blackColor,
                    ),
                buttonColor: primaryColor,
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(primary: primaryColor)),
                outlinedButtonTheme: OutlinedButtonThemeData(
                    style: OutlinedButton.styleFrom(primary: primaryColor)),
                buttonTheme: ButtonThemeData(
                  buttonColor: primaryColor,
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: primaryColor,
                ),
                iconTheme:
                    Theme.of(context).iconTheme.copyWith(color: primaryColor),
                primaryIconTheme:
                    Theme.of(context).iconTheme.copyWith(color: primaryColor),
              ),
              initialRoute: RoutePaths.SPLASH,
              onGenerateRoute: Router.onGenerateRoute,
            );
          }),
    );
  }
}

///  ->  4 ways
/// 1. home named argument  --- first screen to be rendered is SplashScreen()
/// 2. routes named arg --- searches for the map -> initialRoute( if not provided, replace it with /)
/// 3. onGenerateRoute ---
/// 4. onUnknownRoute --- if no route found

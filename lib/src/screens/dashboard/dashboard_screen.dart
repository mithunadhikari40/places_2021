import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:places/src/core/base_widget.dart';
import 'package:places/src/core/constants/route_paths.dart';
import 'package:places/src/screens/dashboard/explore_screen.dart';
import 'package:places/src/screens/dashboard/favorite_screen.dart';
import 'package:places/src/screens/dashboard/profile_screen.dart';
import 'package:places/src/utils/snackbar_helper.dart';
import 'package:places/src/viewmodels/dashboard/dashboard_view_model.dart';
import 'package:places/src/widgets/shared/app_colors.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget  {
  static const screens = [ExploreScreen(), FavoriteScreen(), ProfileScreen()];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<DashboardViewModel>(
        model: DashboardViewModel(service: Provider.of(context)),
        onModelReady: (model) => _onModelReady(model,context),
        builder: (context, DashboardViewModel model, Widget? child) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: _buildAppBar(model, context),
            body: _buildBody(model),
            bottomNavigationBar: _buildBottomNavigationBar(context, model),
            drawer: _buildNavigationDrawer(model, context),
          );
        });
  }

  AppBar _buildAppBar(DashboardViewModel model, BuildContext context) {
    if(model.currentIndex == 2) return AppBar(toolbarHeight: 0);
    return AppBar(
      title:
          Text(model.getAppbarTitle()),
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: blackColor87,
        ),
        onPressed: () {
          bool drawerOpen = _scaffoldKey.currentState!.isDrawerOpen;
          if (!drawerOpen) {
            _scaffoldKey.currentState!.openDrawer();
          }
        },
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.add,
            size: 40,
            color: blackColor87,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(RoutePaths.ADD_NEW);
          },
        ),
        SizedBox(
          width: 16,
        )
      ],
    );
  }

  Widget _buildBody(DashboardViewModel model) {
    return screens[model.currentIndex];
  }

  Widget _buildBottomNavigationBar(
      BuildContext context, DashboardViewModel model) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outlined), label: "Favorite"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
      onTap: model.changeTab,
      currentIndex: model.currentIndex,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedIconTheme: IconThemeData(color: blackColor87),
      unselectedIconTheme: IconThemeData(color: blackColor54),
      selectedLabelStyle: TextStyle(fontSize: 18, color: blackColor87),
      unselectedLabelStyle: TextStyle(fontSize: 16, color: blackColor87),
      selectedItemColor: blackColor87,
      unselectedItemColor: blackColor54,
    );
  }

  Widget _buildNavigationDrawer(
      DashboardViewModel model, BuildContext context) {
    return Container(
      width: 200,
      color: whiteColor,
      child: Drawer(
        child: Column(
          children: [
            Container(
              color: blackColor54,
              height: 100,
            ),
            ListTile(
              title: Text("Explore"),
              trailing: Icon(Icons.explore),
              selected: model.currentIndex == 0,
              onTap: () {
                model.changeTab(0);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text("Favorite"),
              trailing: Icon(Icons.favorite_outlined),
              selected: model.currentIndex == 1,
              onTap: () {
                model.changeTab(1);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text("Profile"),
              trailing: Icon(Icons.person),
              selected: model.currentIndex == 2,
              onTap: () {
                model.changeTab(2);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text("About us"),
              trailing: Icon(Icons.info),
            ),
            ListTile(
              title: Text("Log out"),
              trailing: Icon(Icons.exit_to_app),
            ),
          ],
        ),
      ),
    );
  }

 Future<void> _onModelReady(DashboardViewModel model, BuildContext context) async {
   Location location =  Location();

   bool? _serviceEnabled;
   PermissionStatus? _permissionGranted;
   LocationData? _locationData;

   _serviceEnabled = await location.serviceEnabled();
   if (!_serviceEnabled) {
     _serviceEnabled = await location.requestService();
     if (!_serviceEnabled) {
       showSnackBar(context,"Places needs to have your location turned on to work properly");
       return;
     }
   }

   _permissionGranted = await location.hasPermission();
   if (_permissionGranted == PermissionStatus.denied) {
     _permissionGranted = await location.requestPermission();
     if (_permissionGranted != PermissionStatus.granted) {
       showSnackBar(context,"Places needs to have your permission to access location to work properly");
       return;
     }
   }

   _locationData = await location.getLocation();
   model.setLocation(_locationData);



  }
}























/*
late final FirebaseMessaging _messaging;

  @override
  initState(){
    super.initState();
    registerNotification();
  }

  void registerNotification() async {
    // 1. Initialize the Firebase app


    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    _messaging.getToken();


    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      // TODO: handle the received notifications

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );


      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

 */
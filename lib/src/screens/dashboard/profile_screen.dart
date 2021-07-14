import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:places/src/screens/dashboard/my_places.dart';
import 'package:places/src/screens/dashboard/profile_detail.dart';
import 'package:places/src/widgets/shared/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
        return [_buildHeader(context, innerBoxScrolled)];
      },
      body: _buildTabBarView(context),
    );
  }

  Widget _buildTabBarView(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: [
        ProfileDetail(),
        MyPlacesScreen(),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, bool innerBoxScrolled) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      forceElevated: innerBoxScrolled,
      title: Text("Profile", style: Theme.of(context).textTheme.headline6),
      bottom: TabBar(
        controller: _tabController,
        tabs: [
          Tab(icon: Icon(Icons.person), text: "Me"),
          Tab(icon: Icon(Icons.location_on_outlined), text: "My Places"),
        ],
        physics: BouncingScrollPhysics(),
        indicatorColor: blackColor87,
        labelColor: blackColor87,
        labelStyle: TextStyle(color: blackColor87),
        indicatorPadding: EdgeInsets.all(8),
      ),
    );
  }
}

/*

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: NestedScrollView(
        physics: NeverScrollableScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
          return [_buildSliverAppBar(innerBoxScrolled, context)];
        },
        body: _buildTabBarView(context),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(bool innerBoxScrolled, BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      backgroundColor: whiteColor,
      forceElevated: innerBoxScrolled,
      title: Text(
        "Profile",
        style: Theme.of(context).textTheme.headline6,
      ),
      // flexibleSpace:
      //      _buildProfileDetail(context) ,
      // expandedHeight:
      //     MediaQuery.of(context).size.height / 2.5 ,

      bottom: TabBar(
        labelStyle: Theme.of(context)
            .textTheme
            .subtitle2!
            .copyWith(color: blackColor87),
        labelColor: blackColor87,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 8),
        automaticIndicatorColorAdjustment: true,
        enableFeedback: true,
        indicatorColor: blackColor87,
        tabs: <Tab>[
          Tab(
            text: "Profile",
            icon: Icon(Icons.person),
          ),
          Tab(
            text: "My Places",
            icon: Icon(Icons.place_sharp),

          ),
        ],
        controller: _tabController,
      ),
    );
  }

  Widget _buildFullName(BuildContext context) {
    return Text("Himal Karmacharya",
        style: Theme.of(context).textTheme.headline6);
  }

  Widget _buildPhoneNumber(BuildContext context) {
    return Text("+97798587456521",
        style: Theme.of(context).textTheme.subtitle1);
  }

  Widget _buildProfileDetail(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 6,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://cdn.pixabay.com/photo/2015/03/04/22/35/head-659652_1280.png'),
                fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 18,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://cdn.pixabay.com/photo/2015/03/04/22/35/head-659652_1280.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width / 3.0 - 8),
                    border: Border.all(
                      color: Colors.white,
                      width: 10.0,
                    ),
                  ),
                ),
                _buildFullName(context),
                SizedBox(height: 12),
                _buildPhoneNumber(context),
                Divider(),
              ],
            ),
          ),
        )
      ],
    );
  }

  TabBarView _buildTabBarView(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      physics: BouncingScrollPhysics(),
      children: [
        _buildProfileSettings(context),
        _buildProfileSettings(context),
      ],
    );
  }

  Widget _buildProfileSettings(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          _buildProfileDetail(context),
          SizedBox(
            height: MediaQuery.of(context).size.height / 6,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              "Update Name",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.email),
            title: Text("Update email",
                style: Theme.of(context).textTheme.subtitle1),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text("Update Password",
                style: Theme.of(context).textTheme.subtitle1),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.phone_android),
            title: Text("Update Phone",
                style: Theme.of(context).textTheme.subtitle1),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.security),
            title: Text("Privacy Policy",
                style: Theme.of(context).textTheme.subtitle1),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.file_copy_sharp),
            title: Text("Terms and Conditions",
                style: Theme.of(context).textTheme.subtitle1),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info),
            onTap: () {
              showAboutDialog(
                  context: context,
                  applicationVersion: "1.0.1",
                  applicationName: "Places App",
                  applicationLegalese:
                      "All right reserved @2021 Broadway Infosys Pvt. Ltd.");
            },
            title:
                Text("About us", style: Theme.of(context).textTheme.subtitle1),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title:
                Text("Log out", style: Theme.of(context).textTheme.subtitle1),
          ),
        ],
      ),
    );
  }
}
*/

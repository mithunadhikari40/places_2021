import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(8),
      child: ListView(
        children: [
          Stack(
            children: [
              _buildCoverImage(context),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: screenSize.height / 4.2 - 60 - 4),
                  _buildProfileImage(context),
                  SizedBox(height: 8),
                  _buildFullName(context),
                  SizedBox(height: 12),
                  _buildPhoneNumber(context),
                  Flexible(
                      fit: FlexFit.loose, child: _buildProfileSettings(context))
                ],
              )
            ],
          ),
        ],
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

  Widget _buildProfileImage(BuildContext context) {
    return Container(
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
        ],
      ),
    );
  }

  Widget _buildCoverImage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4.2,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                'https://cdn.pixabay.com/photo/2015/03/04/22/35/head-659652_1280.png'),
            fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildProfileSettings(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
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
            leading: Icon(Icons.password),
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
            leading: Icon(Icons.lock),
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
            leading: Icon(Icons.file_copy_sharp),
            title:
                Text("Log out", style: Theme.of(context).textTheme.subtitle1),
          ),
        ],
      ),
    );
  }
}

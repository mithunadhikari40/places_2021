import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:places/src/core/base_widget.dart';
import 'package:places/src/core/constants/route_paths.dart';
import 'package:places/src/model/network_response_model.dart';
import 'package:places/src/utils/image_helper.dart';
import 'package:places/src/utils/show_overlay_loading_indicator.dart';
import 'package:places/src/utils/snackbar_helper.dart';
import 'package:places/src/viewmodels/dashboard/profile_detail_view_model.dart';
import 'package:places/src/widgets/bottomsheet/change_name_bottom_sheet.dart';
import 'package:places/src/widgets/bottomsheet/change_password_bottom_sheet.dart';
import 'package:places/src/widgets/bottomsheet/choose_image_option_bottom_sheet.dart';
import 'package:places/src/widgets/bottomsheet/log_out_bottom_sheet.dart';
import 'package:places/src/widgets/shared/app_colors.dart';
import 'package:provider/provider.dart';

class ProfileDetail extends StatelessWidget {
  const ProfileDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ProfileDetailViewModel>(
        model: ProfileDetailViewModel(service: Provider.of(context)),
        builder: (context, ProfileDetailViewModel model, snapshot) {
          return ListView(
            children: [
              _buildUserDetail(context, model),
              //-- create a enough space,
              SizedBox(height: MediaQuery.of(context).size.height / 5.2),
              _buildChangeNameSection(context, model),
              Divider(), _buildChangeEmailSection(context),
              Divider(), _buildChangePhoneSection(context),
              Divider(), _buildChangePasswordSection(context, model),
              Divider(), _buildPrivacyPolicySection(context),
              Divider(), _buildPrivacyTermsAndConditionSection(context),
              Divider(), _buildAboutUsSection(context),
              Divider(), _buildLogOutSection(context, model),
            ],
          );
        });
  }

  Widget _buildChangeNameSection(
      BuildContext context, ProfileDetailViewModel model) {
    return ListTile(
      title: Text(
        "Change Name",
        style: Theme.of(context).textTheme.subtitle2,
      ),
      leading: Icon(Icons.person),
      onTap: () {
        showChangeNameBottomSheet(context, (String newName) {
          _updateName(newName, context, model);
        });
      },
    );
  }

  Widget _buildChangeEmailSection(BuildContext context) {
    return ListTile(
      title: Text(
        "Change Email",
        style: Theme.of(context).textTheme.subtitle2,
      ),
      leading: Icon(Icons.email),
      onTap: () {},
    );
  }

  Widget _buildChangePhoneSection(BuildContext context) {
    return ListTile(
      title: Text(
        "Change Phone",
        style: Theme.of(context).textTheme.subtitle2,
      ),
      leading: Icon(Icons.phone_android_outlined),
      onTap: () {},
    );
  }

  Widget _buildChangePasswordSection(
      BuildContext context, ProfileDetailViewModel model) {
    return ListTile(
      title: Text(
        "Change Password",
        style: Theme.of(context).textTheme.subtitle2,
      ),
      leading: Icon(Icons.lock),
      onTap: () {
        showChangePasswordBottomSheet(context, (String newPassword) {
          _updatePassword(context, model, newPassword);
        });
      },
    );
  }

  Widget _buildPrivacyPolicySection(BuildContext context) {
    return ListTile(
      title: Text(
        "Privacy Policy",
        style: Theme.of(context).textTheme.subtitle2,
      ),
      leading: Icon(Icons.privacy_tip_outlined),
      onTap: () {},
    );
  }

  Widget _buildPrivacyTermsAndConditionSection(BuildContext context) {
    return ListTile(
      title: Text(
        "Terms and Conditions",
        style: Theme.of(context).textTheme.subtitle2,
      ),
      leading: Icon(Icons.file_copy_sharp),
      onTap: () {},
    );
  }

  Widget _buildAboutUsSection(BuildContext context) {
    return ListTile(
      title: Text(
        "About us",
        style: Theme.of(context).textTheme.subtitle2,
      ),
      leading: Icon(Icons.info),
      onTap: () {
        showAboutDialog(
            context: context,
            applicationVersion: "1.0.0",
            applicationName: "Places",
            applicationLegalese: "All right reserved @2021, XYZ Pvt. Ltd.",
            applicationIcon: FlutterLogo(
              size: 100,
            ));
      },
    );
  }

  Widget _buildLogOutSection(
      BuildContext context, ProfileDetailViewModel model) {
    return ListTile(
      title: Text(
        "Log out",
        style: Theme.of(context).textTheme.subtitle2,
      ),
      leading: Icon(Icons.exit_to_app),
      onTap: () async {
        showLogoutBottomSheet(context, () {
          _logout(context, model);
        });
        //
      },
    );
  }

  Future<void> _logout(
      BuildContext context, ProfileDetailViewModel model) async {
    final response =
        await showOverlayLoadingIndicator<bool>(context, model.logout());

    // if response is true, then logout, else show an error message
    if (response) {
      //log out the user
      Navigator.of(context).pushNamedAndRemoveUntil(RoutePaths.LOGIN,(route){
        return route.settings.name == RoutePaths.LOGIN;
      });
    } else {
      //show an error
      showSnackBar(context, "Could not log you out now, please try again");
    }
  }

  Stack _buildUserDetail(BuildContext context, ProfileDetailViewModel model) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _buildCoverImage(context, model),
        Positioned(
          top: MediaQuery.of(context).size.height / 12,
          left: 0,
          right: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildProfilePicture(context, model),
              SizedBox(height: 8),
              Text(
                "${model.currentUser.name}",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 8),
              Text("${model.currentUser.email}"),
              SizedBox(height: 8),
              Text("${model.currentUser.phone}"),
              SizedBox(height: 8),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildProfilePicture(
      BuildContext context, ProfileDetailViewModel model) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        showChoseImageOptionBottomSheet(context, (ImageSource source) {
          _chooseProfilePic(context, model, source);
        });
      },
      child: Container(
        width: size.width / 3,
        height: size.width / 3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.width / 6),
            border: Border.all(width: 10, color: whiteColor),
            image: DecorationImage(
                fit: BoxFit.contain,
                image: NetworkImage(model.currentUser.profilePic != null
                    ? getImage(model.currentUser.profilePic!)
                    : "https://cdn.pixabay.com/photo/2015/03/04/22/35/head-659652_1280.png"))),
      ),
    );
  }

  Widget _buildCoverImage(BuildContext context, ProfileDetailViewModel model) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: (){
        showChoseImageOptionBottomSheet(context, (ImageSource source){
          _chooseCoverPic(context,model,source);
        });
      },
      child: Container(
        width: size.width,
        height: size.height / 5,
        child: Image.network(
          model.currentUser.coverPic != null
              ? getImage(model.currentUser.coverPic!)
              : "https://cdn.pixabay.com/photo/2015/03/04/22/35/head-659652_1280.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future<void> _updateName(String newName, BuildContext context,
      ProfileDetailViewModel model) async {
    final response = await showOverlayLoadingIndicator<NetworkResponseModel>(
        context, model.updateName(newName));

    if (response.status) {
      showSnackBar(context, "Name updated successfully");
    } else {
      showSnackBar(context, response.message!);
    }
  }

  void _updatePassword(BuildContext context, ProfileDetailViewModel model,
      String newPassword) async {
    final response = await showOverlayLoadingIndicator<NetworkResponseModel>(
      context,
      model.updatePassword(newPassword),
    );

    if (response.status) {
      showSnackBar(context, "Password updated successfully");
    } else {
      showSnackBar(context, response.message!);
    }
  }

  Future<void> _chooseProfilePic(BuildContext context,
      ProfileDetailViewModel model, ImageSource source) async {
    PickedFile? pickedImage = await ImagePicker().getImage(source: source);
    if (pickedImage == null) {
      showSnackBar(context, "Could not pick image");
    } else {
      File file = File(pickedImage.path);
      final response = await showOverlayLoadingIndicator<NetworkResponseModel>(
        context,
        model.updateProfilePic(file.absolute.path),
      );
      if (response.status) {
        showSnackBar(context, "Profile picture updated successfully");
      } else {
        showSnackBar(context, response.message!);
      }
    }
  }

  Future<void> _chooseCoverPic(BuildContext context, ProfileDetailViewModel model, ImageSource source) async {
    PickedFile? pickedImage = await ImagePicker().getImage(source: source);
    if (pickedImage == null) {
      showSnackBar(context, "Could not pick image");
    } else {
      File file = File(pickedImage.path);
      final response = await showOverlayLoadingIndicator<NetworkResponseModel>(
        context,
        model.updateCoverPic(file.absolute.path),
      );
      if (response.status) {
        showSnackBar(context, "Cover picture updated successfully");
      } else {
        showSnackBar(context, response.message!);
      }
    }
  }
}

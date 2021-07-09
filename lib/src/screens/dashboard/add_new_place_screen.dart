import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:places/src/core/base_widget.dart';
import 'package:places/src/utils/location_helper.dart';
import 'package:places/src/utils/snackbar_helper.dart';
import 'package:places/src/viewmodels/dashboard/places_view_model.dart';
import 'package:places/src/widgets/bottomsheet/choose_image_option_bottom_sheet.dart';
import 'package:places/src/widgets/input_name.dart';
import 'package:provider/provider.dart';

class AddNewPlaceScreen extends StatelessWidget {
  AddNewPlaceScreen({Key? key}) : super(key: key);
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<PlacesViewModel>(
        model: PlacesViewModel(service: Provider.of(context)),
        builder: (context, PlacesViewModel model, Widget? child) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Add New Place"),
            ),
            body: _buildBody(context, model),
          );
        });
  }

  Widget _buildBody(BuildContext context, PlacesViewModel model) {
    return ListView(
      children: [
        InputName(
          controller: _nameController,
          text: "Place Name",
          hint: "e.g Lalitpur",
          icon: Icons.place,
        ),
        InputName(
          controller: _descriptionController,
          text: "Place description",
          hint: "describe this place",
          icon: Icons.message,
          lines: 3,
        ),
        _buildInputImage(context, model),
        SizedBox(
          height: 12,
        ),
        _buildStaticImage(context, model),
        SizedBox(
          height: 12,
        ),



      ],
    );
  }

  Widget _buildInputImage(BuildContext context, PlacesViewModel model) {
    // check if the image is already selected
    // if no then show a section showing no image selected
    // else show the image
    return InkWell(
      onTap: () {
        _pickImage(context, model);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 4,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: model.imagePath == null
            ? Center(
                child: Text(
                  "No Image selected",
                  style: Theme.of(context).textTheme.headline6,
                ),
              )
            : Image.file(File(model.imagePath!), fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildStaticImage(BuildContext context, PlacesViewModel model) {
    // check if the image is already selected
    // if no then show a section showing no image selected
    // else show the image
    return InkWell(
      onTap: (){
        model.setLocation(LatLng(27.8434, 84.333));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 5,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: model.location == null
            ? Center(
                child: Text(
                  "No location chosen",
                  style: Theme.of(context).textTheme.headline6,
                ),
              )
            : Image.network(
                LocationHelper.generateLocationPreviewImage(model.location!),
                fit: BoxFit.cover),
      ),
    );
  }

  void _pickImage(BuildContext context, PlacesViewModel model) {
    showChoseImageOptionBottomSheet(context, (ImageSource source) async {
      PickedFile? pickedImage = await ImagePicker().getImage(source: source);
      if (pickedImage == null) {
        showSnackBar(context, "No image selected, please choose again");
        return;
      }
      File file = File(pickedImage.path);
      model.setImage(file.absolute.path);
    });
  }
}

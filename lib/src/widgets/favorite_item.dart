import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:places/src/model/dashboard/place_model.dart';
import 'package:places/src/utils/image_helper.dart';
import 'package:places/src/utils/location_helper.dart';
import 'package:places/src/widgets/shared/app_colors.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem(
      {Key? key,
      required this.place,
      this.location,
      required this.onFavoriteRemoved})
      : super(key: key);
  final PlaceModel place;
  final LocationData? location;
  final ValueChanged<PlaceModel> onFavoriteRemoved;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ClipRRect(
                    child: Image.network(getImage(place.image!)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  SizedBox(height: 8),
                  Text("${place.name}",
                      style: Theme.of(context).textTheme.headline6),
                  SizedBox(height: 8),
                  Text("Near: ${place.monument}"),
                  SizedBox(height: 8),
                  location == null
                      ? Text("Some distance away")
                      : Text(
                          "${LocationHelper.calculateDistanceInKm(latitude1: location!.latitude!, longitude1: location!.longitude!, latitude2: place.latitude!, longitude2: place.longitude!)} KM"),
                  SizedBox(height: 8),
                  Text("${place.description}"),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            right: 0,
            top: 0,
            child: CircleAvatar(
              backgroundColor: redColor,
              radius: 20,
              child: IconButton(
                onPressed: () => onFavoriteRemoved(place),
                icon: Icon(Icons.clear),
              ),
            ))
      ],
    );
  }
}

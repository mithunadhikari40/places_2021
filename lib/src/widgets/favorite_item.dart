import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:places/src/model/dashboard/place_model.dart';
import 'package:places/src/utils/image_helper.dart';
import 'package:places/src/utils/location_helper.dart';
import 'package:places/src/widgets/shared/app_colors.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({Key? key, required this.place, this.location, required this.onItemRemoved})
      : super(key: key);
  final PlaceModel place;
  final LocationData? location;
  final Function(PlaceModel place) onItemRemoved;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Stack(
        children: [
          Card(
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
                          "${LocationHelper.calculateDistanceInKm(latitude1: location!.latitude!, longitude1: location!.longitude!, latitude2: place.latitude!, longitude2: place.longitude!).toStringAsFixed(1)} KM"),
                  SizedBox(height: 8),
                  location == null
                      ? Text("Few moments away")
                      : Text(
                          "${LocationHelper.getApproximateTravelTime(latitude1: location!.latitude!, longitude1: location!.longitude!, latitude2: place.latitude!, longitude2: place.longitude!)}"),
                  SizedBox(height: 8),
                  Text("${place.description}"),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: InkWell(
              onTap: () => onItemRemoved(place),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: redColor,
                child: Center(
                  child: Icon(Icons.clear),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

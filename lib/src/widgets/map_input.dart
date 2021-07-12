import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapInput extends StatefulWidget {
  final Function(LatLng location) onMapTapped;
  final LatLng currentLocation;
  const MapInput({Key? key, required this.onMapTapped, required this.currentLocation}) : super(key: key);

  @override
  _MapInputState createState() => _MapInputState();
}

class _MapInputState extends State<MapInput> {
  late LatLng _currentLocation = widget.currentLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose from Map"),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).pop(_currentLocation);
          }, icon: Icon(Icons.check_circle_outline))
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _currentLocation,
          zoom: 14.25
        ),
        padding: EdgeInsets.all(10),
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onTap: (LatLng location){
      setState(() {
        _currentLocation = location;
      });
        },
        markers: {
          Marker(
            markerId: MarkerId(_currentLocation.toString()),
            infoWindow: InfoWindow(title: "You are here"),
            position: _currentLocation

          )
        },
      ),
    );
  }
}

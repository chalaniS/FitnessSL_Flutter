import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GymMap extends StatelessWidget {
  final String latitude;
  final String longitude;

  GymMap({required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    final gymLocation = LatLng(latitude as double, longitude as double);

    return Scaffold(
      appBar: AppBar(
        title: Text("Gym Location"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: gymLocation,
          zoom: 15.0, // Adjust the initial zoom level
        ),
        markers: {
          Marker(
            markerId: MarkerId("gymLocation"),
            position: gymLocation,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure), // Customize the marker icon
          ),
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GymMap extends StatelessWidget {
  final LatLng gymLocation = LatLng(7.293736697003451, 80.64131426545106);

  @override
  Widget build(BuildContext context) {
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

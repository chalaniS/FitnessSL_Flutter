import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../constants.dart';

class GymMap extends StatelessWidget {
  final double latitude;
  final double longitude;

  GymMap({required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    final gymLocation = LatLng(latitude, longitude);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
        backgroundColor: darkBlue,
        title: Text(
          'Gyms in Sri Lanka',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26.0,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.52,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
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

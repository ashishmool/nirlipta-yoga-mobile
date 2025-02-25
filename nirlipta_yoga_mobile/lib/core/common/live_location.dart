import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LiveLocationScreen extends StatelessWidget {
  final double latitude;
  final double longitude;

  LiveLocationScreen({required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    LatLng currentPosition = LatLng(latitude, longitude);

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: currentPosition,
        zoom: 14.0,
      ),
      markers: {
        Marker(
          markerId: MarkerId("currentLocation"),
          position: currentPosition,
          infoWindow: InfoWindow(title: "You are here"),
        ),
      },
    );
  }
}

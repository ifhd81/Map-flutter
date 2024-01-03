import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  GoogleMapController? mapController;
  LatLng? currentPosition ;
  StreamSubscription<Position>? positionStream;

  @override
  void initState() {
    super.initState();
    determinePosition().whenComplete(() {
      _getCurrentLocation();
    });
    _startLocationStream();
  }

  @override
  void dispose() {
    positionStream?.cancel(); // Cancel the location stream when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: currentPosition ?? LatLng(21.5687815,39.1356415),
            zoom: 15,
          ),
          onMapCreated: (controller) {
            setState(() {
              mapController = controller;
            });
          },
          onCameraMove: (CameraPosition position ){
            setState(() {

            });
          },
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          
        ),
      ),
    );
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  void _startLocationStream() {
    print('Amr is playing in code!123');
    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 1,
      ),
       // Set a distance threshold for updates (e.g., 10 meters)
    ).listen((Position position) {
      setState(() {
        currentPosition = LatLng(position.latitude, position.longitude);
        mapController?.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: currentPosition!, zoom: 25)
          //17 is new zoom level
        ));
      });

      // Print a message when the location changes
      print('User is moving! Latitude: ${position.latitude}, Longitude: ${position.longitude}');

      // Add your specific action here, e.g., play a sound
      print('Amr is playing in code!');
    });
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }


}

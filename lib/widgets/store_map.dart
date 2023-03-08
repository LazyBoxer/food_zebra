import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class StoreMap extends StatefulWidget {
  final LatLng targetPosition;

  const StoreMap({Key? key, required this.targetPosition}) : super(key: key);

  @override
  StoreMapState createState() => StoreMapState();
}

class StoreMapState extends State<StoreMap> {
  final Completer<GoogleMapController> _controller = Completer();
  final Location _location = Location();
  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      debugPrint('locationData start');
      var locationData = await _location.getLocation();
      debugPrint('locationData: $locationData');
      setState(() {
        _currentPosition = LatLng(locationData.latitude ?? 0.0, locationData.longitude ?? 0.0);
      });
    } catch (error) {
      debugPrint('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _currentPosition == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: _currentPosition!,
              zoom: 15,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('currentPosition'),
                position: _currentPosition!,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                infoWindow: const InfoWindow(title: 'You are here'),
              ),
              Marker(
                markerId: const MarkerId('targetPosition'),
                position: widget.targetPosition,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                infoWindow: const InfoWindow(title: 'Target'),
              ),
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          );
  }
}

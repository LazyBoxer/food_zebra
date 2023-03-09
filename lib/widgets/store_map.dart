import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StoreMap extends StatefulWidget {
  final LatLng targetPosition;

  const StoreMap({Key? key, required this.targetPosition}) : super(key: key);

  @override
  StoreMapState createState() => StoreMapState();
}

class StoreMapState extends State<StoreMap> {
  final Completer<GoogleMapController> _controller = Completer();
  final LatLng _currentPosition = const LatLng(25.048174640602493, 121.5171156616663);

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    // bool serviceEnabled;
    // PermissionStatus permissionGranted;

    // serviceEnabled = await _location.serviceEnabled();
    // if (!serviceEnabled) {
    //   serviceEnabled = await _location.requestService();
    //   if (!serviceEnabled) {
    //     return;
    //   }
    // }

    // permissionGranted = await _location.hasPermission();
    // if (permissionGranted == PermissionStatus.denied) {
    //   permissionGranted = await _location.requestPermission();
    //   if (permissionGranted != PermissionStatus.granted) {
    //     return;
    //   }
    // }

    // try {
    //   // LocationData locationData = await _location.getLocation();
    //   setState(() {
    //     _currentPosition = const LatLng(25.048174640602493, 121.5171156616663);
    //   });
    // } catch (error) {
    //   debugPrint('Error: $error');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: _currentPosition,
        zoom: 15,
      ),
      markers: {
        Marker(
          markerId: const MarkerId('currentPosition'),
          position: _currentPosition,
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
      cameraTargetBounds: _getBounds(),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  CameraTargetBounds _getBounds() {
    final southwest = LatLng(
      _currentPosition.latitude < widget.targetPosition.latitude
          ? _currentPosition.latitude
          : widget.targetPosition.latitude,
      _currentPosition.longitude < widget.targetPosition.longitude
          ? _currentPosition.longitude
          : widget.targetPosition.longitude,
    );
    final northeast = LatLng(
      _currentPosition.latitude > widget.targetPosition.latitude
          ? _currentPosition.latitude
          : widget.targetPosition.latitude,
      _currentPosition.longitude > widget.targetPosition.longitude
          ? _currentPosition.longitude
          : widget.targetPosition.longitude,
    );
    return CameraTargetBounds(
        LatLngBounds(southwest: southwest, northeast: northeast));
  }
}

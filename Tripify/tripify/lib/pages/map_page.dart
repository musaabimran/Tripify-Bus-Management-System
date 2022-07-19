import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class SMap extends StatefulWidget {
  @override
  State<SMap> createState() => Map();
}

// ignore: use_key_in_widget_constructors
class Map extends State<SMap> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = [];
  String location = 'Null, Press Button';
  var _lastMapPosition = "first;";

  late Position curpos;
  var gloc = Geolocator();

  String googleAPIKey = "AIzaSyBnCr-R2SpO1j-IiSl1KxGZyJrMQeaxdA8";
  //get polylinePoints async => null;
  //Set<Polyline> = _setpolylines = Set<Polyline>();
  @override
  void dispose() {
    //newGoogleMapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    locpos();
    super.initState();
  }

  void locpos() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final firstMarker = Marker(
        markerId: MarkerId("First"),
        position: LatLng(pos.latitude, pos.longitude),
        infoWindow: InfoWindow(title: "Home", snippet: '7.15 AM'),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed,
        ));

    final secondMarker = Marker(
        markerId: MarkerId("Last"),
        position: LatLng(33.656204, 73.016743),
        infoWindow: InfoWindow(title: "FAST University", snippet: '8.15 AM'),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueAzure,
        ));

    setState(() {
      markers.add(firstMarker);
      markers.add(secondMarker);
    });
  }

  // ignore: prefer_const_constructors
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: const LatLng(33.560233, 73.133939),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          child: GoogleMap(
              //polylines: Set<Polyline>.of(polylines.values),
              mapType: MapType.normal,
              onTap: (latlang) {},
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition: const CameraPosition(
                  target: LatLng(33.656204, 73.016743), zoom: 12),
              onMapCreated: (GoogleMapController controller) {
                locpos();
              },
              markers: markers.map((e) => e).toSet()),
        ),
      ),
    );
  }

  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}

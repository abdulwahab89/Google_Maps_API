import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class GetUserLocation extends StatefulWidget {
  const GetUserLocation({Key? key}) : super(key: key);

  @override
  State<GetUserLocation> createState() => _GetUserLocationState();
}

class _GetUserLocationState extends State<GetUserLocation> {
  List<Marker> markers = [];
  final Completer<GoogleMapController> _controller = Completer();
  // Future<Position> checkPosition() async {
  //   bool isLocationEnabled;
  //   Geolocator.requestPermission().then((value) {
  //     debugPrint('asked');
  //   }).onError((error, stackTrace) {
  //     debugPrint(
  //         "THIS ERRRRRRRRRROR !!!!!!!!!!!!!!!!!!!!!!!!" + error.toString());
  //   });
  //   LocationPermission permission;
  //   isLocationEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (isLocationEnabled) {
  //     permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.always ||
  //         permission == LocationPermission.whileInUse) {
  //       return await Geolocator.getCurrentPosition();
  //     }
  //   }
  //   return Future.error("Something occurred");
  // }

  // gotoLocation() async {
  //   Position location = await Geolocator.getCurrentPosition();
  //   GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(
  //       CameraPosition(target: LatLng(location.latitude, location.longitude))));
  //   setState(() {});
  // }

  final CameraPosition _kGoogleFlex =
      const CameraPosition(zoom: 14, target: LatLng(24.244242, 26.43424));
  Future<Position> getCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {});
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getCurrentLocation().then((value) async {
            markers.add(Marker(
                markerId: MarkerId('2'),
                position: LatLng(value.latitude, value.longitude)));
            CameraPosition position = CameraPosition(
                zoom: 14, target: LatLng(value.latitude, value.longitude));
            GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(position));

            setState(() {});
          }).onError((error, stackTrace) {});
        },
      ),
      body: GoogleMap(
        initialCameraPosition: _kGoogleFlex,
        markers: Set<Marker>.of((markers)),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}

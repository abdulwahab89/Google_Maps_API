import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Marker> _markers = [];
  final List<Marker> _list = [
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(25.40539869023733, 68.34745205086637),
        infoWindow: InfoWindow(
          title: 'my location',
        )),
    const Marker(
        markerId: MarkerId('2'),
        position: LatLng(25.40539869023734, 68.34745205086638),
        infoWindow: InfoWindow(
          title: 'my location 2 ',
        ))
  ];

  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGoogleFlex = CameraPosition(
    target: LatLng(25.40539869023733, 68.34745205086637),
    zoom: 14,
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markers.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          GoogleMapController controller = await _controller.future;
          controller
              .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(24.4241412, 43.13123123212),
          )));
          setState(() {});
        },
      ),
      body: GoogleMap(
        markers: Set<Marker>.of((_markers)),
        mapType: MapType.normal,
        compassEnabled: true,
        myLocationEnabled: true,
        initialCameraPosition: _kGoogleFlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}

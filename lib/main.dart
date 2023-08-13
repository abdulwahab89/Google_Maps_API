import 'package:flutter/material.dart';
import 'package:google_maps_api/get_user_location.dart';
import 'package:google_maps_api/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetUserLocation(),
    );
  }
}

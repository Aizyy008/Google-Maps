import 'package:flutter/material.dart';
import 'package:googlemap/convert_latlang_to_address.dart';
import 'package:googlemap/custom_marker_info_window.dart';
import 'package:googlemap/customer_marker_screen.dart';
import 'package:googlemap/google_places_api.dart';
import 'package:googlemap/home_screen.dart';
import 'package:googlemap/network_image_marker.dart';
import 'package:googlemap/polygon_screen.dart';
import 'package:googlemap/polyline.dart';
import 'package:googlemap/style_googlemap_screen.dart';
import 'package:googlemap/user_current_location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StyleGoogleMapScreen(),
    );
  }
}


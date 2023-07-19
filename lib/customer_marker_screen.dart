import "dart:async";
import 'dart:typed_data';
import "dart:ui" as ui;
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

class CustomMakerScreen extends StatefulWidget {
  const CustomMakerScreen({super.key});

  @override
  State<CustomMakerScreen> createState() => _CustomMakerScreenState();
}

class _CustomMakerScreenState extends State<CustomMakerScreen> {
  static Completer<GoogleMapController> mainController = Completer();
  static const CameraPosition initialPosition = CameraPosition(
      target: LatLng(32.33531579045427, 74.35289002469037), zoom: 14);
  List<String> images = [
    'images/car.png',
    'images/location.png',
    'images/motorcycle.png',
    'images/pin.png',
    'images/sport-car.png',
    'images/bus.png'
  ];
Uint8List? markerImages;
  List<Marker> markers = [];
  List<LatLng> lst = [
    LatLng(32.33531579045427, 74.35289002469037),
    LatLng(32.33483521698612, 74.36324279400276),
    LatLng(32.3344495523635, 74.361976426542),
    LatLng(32.33406881203622, 74.35714845036172),
    LatLng(32.33097189706043, 74.34546411032888),
    LatLng(32.33235891944789, 74.35228765006937),
  ];

Future<Uint8List> getBytesFromAssets(String path, int width) async{
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo frameInfo = await codec.getNextFrame();
  return (await frameInfo.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    // markers.addAll(lst);
  }

  loadData() async{
    for (int i = 0; i < lst.length; i++) {
      final Uint8List markerIcon = await getBytesFromAssets(images[i], 100);
      markers.add(Marker(
        markerId: MarkerId(i.toString()),
        icon: BitmapDescriptor.fromBytes(markerIcon),
        position: lst[i],
        infoWindow: InfoWindow(
title: "This is title marker "+(i+1).toString()
        )

      ));
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: initialPosition,
          markers: Set<Marker>.of(markers),
          compassEnabled: true,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            mainController.complete(controller);
          },
        ),
      ),
    );
  }
}

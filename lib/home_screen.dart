import "dart:async";

import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:googlemap/convert_latlang_to_address.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  static Completer<GoogleMapController> controller= Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(32.33531579045427, 74.35289002469037),
    zoom: 14.4746,
  );

  List<Marker> marker = [];
  List<Marker> list = [
    const Marker(markerId: MarkerId("1"),position: LatLng(32.33531579045427, 74.35289002469037),
    infoWindow: InfoWindow(
      title: "Qasr-e-Shireen Sweets",
      snippet: "Sambrial Road Daska"
    )),
    const Marker(markerId: MarkerId("2"),position: LatLng(33.667432383342195, 73.07526712474558),
        infoWindow: InfoWindow(
            title: "Ranchers",
            snippet: "I-8 Markaz Islamabad"
        )),
    const Marker(markerId: MarkerId("3"),position: LatLng(31.47175779010612, 74.35549928047607),
        infoWindow: InfoWindow(
            title: "Packages Mall",
            snippet: "Walton Road Lahore"
        ),
      
    ),
  ];

  void initState(){
    super.initState();
    marker.addAll(list);
  }
  void dragFunction(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ConvertLatLangToAddress()));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: GoogleMap(initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          markers: Set<Marker>.of(marker),
          onMapCreated: (GoogleMapController _controller) {
            controller.complete(_controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          GoogleMapController _controller = await controller.future;
          _controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(31.47175779010612, 74.35549928047607),
              zoom: 14
          ))
          );
          setState(() {

          });
        },
        child: Icon(Icons.location_on_outlined),
      ),
    );

  }
}

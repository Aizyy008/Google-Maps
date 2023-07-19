import "dart:async";
import "package:custom_info_window/custom_info_window.dart";
import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({super.key});

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {
  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();
  List<Marker> markers = [];
  List<LatLng> lst = [
    LatLng(32.33531579045427, 74.35289002469037),
    LatLng(32.33483521698612, 74.36324279400276),
    LatLng(32.3344495523635, 74.361976426542),
    LatLng(32.33406881203622, 74.35714845036172),
    LatLng(32.33097189706043, 74.34546411032888),
    LatLng(32.33235891944789, 74.35228765006937),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    // markers.addAll(lst);
  }

  loadData() {
    for (int i = 0; i < lst.length; i++) {
      markers.add(Marker(
          markerId: MarkerId(i.toString()),
          icon: BitmapDescriptor.defaultMarker,
          position: lst[i],
          infoWindow:
              InfoWindow(title: "This is title marker " + (i + 1).toString()),
          onTap: () {
            customInfoWindowController.addInfoWindow!(
                Container(
                  height: 300,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: 300,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/4226881/pexels-photo-4226881.jpeg?auto=compress&cs=tinysrgb&w=600"),
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.fitWidth,),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10)
                          ),
                          color: Colors.red
                          )
                        ),
                      Row(
                        children: [
                          Text("Frenchyz Cafe"),
                          Text("Good Taste")
                        ],

                      ),
                      Text("Shop # 31, Askari Market, Bangla Chowk, Model Town, Daska, Sialkot, Punjab 51010")
                    ],
                  ),
                ),
                LatLng(32.33531579045427, 74.35289002469037));
          }));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Custom Marker Info Window",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.lightGreenAccent,
          centerTitle: true,
        ),
        body: Stack(
          children: [
            GoogleMap(
              markers: Set<Marker>.of(markers),
              initialCameraPosition: CameraPosition(
                target: LatLng(32.3344495523635, 74.361976426542),
                zoom: 14,
              ),
              onMapCreated: (GoogleMapController MapController) {
                customInfoWindowController.googleMapController = MapController;
              },
              onTap: (position) {
                customInfoWindowController.hideInfoWindow!();
              },
              onCameraMove: (position) {
                customInfoWindowController.onCameraMove!();
              },
            ),
            CustomInfoWindow(
              controller: customInfoWindowController,
              height: 200,
              width: 300,
              offset: 35,
            )
          ],
        ),
      ),
    );
  }
}

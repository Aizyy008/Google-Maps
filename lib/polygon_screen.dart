import "dart:async";
import "dart:collection";

import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";


class PolygonScreen extends StatefulWidget {
  const PolygonScreen({super.key});

  @override
  State<PolygonScreen> createState() => _PolygonScreenState();
}


class _PolygonScreenState extends State<PolygonScreen> {
  
  Completer<GoogleMapController> mainController = Completer();
  CameraPosition initialPosition = CameraPosition(target: LatLng(32.33776386609393, 74.33731717406899),
  zoom: 14);
  List<LatLng> points = [
    LatLng(32.33776386609393, 74.33731717406899),
    LatLng(32.32601499987885, 74.38177747027129),
    LatLng(32.353732301270554, 74.36001615939348),
    LatLng(32.325843970809686, 74.36517004525986),
    LatLng(32.300832556093965, 74.35327275041323),
    LatLng(32.33776386609393, 74.33731717406899),
  ];
  Set<Polygon> polygon = HashSet<Polygon>();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    polygon.add(Polygon(polygonId: PolygonId("1"), points: points,
    fillColor: Colors.red.withOpacity(0.3),
      geodesic: true,
      strokeWidth: 4,
strokeColor: Colors.deepOrange
    ));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Polygon Screen"),
        centerTitle: true,

      ),
      body: GoogleMap(
        initialCameraPosition: initialPosition,
        onMapCreated: (GoogleMapController controller){
          mainController.complete(controller);
        },
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        myLocationEnabled: false,
        polygons: polygon,
      ),
    );
  }
}

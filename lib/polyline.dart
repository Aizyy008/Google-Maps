import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:flutter/material.dart";
import "dart:async";
class PolylineScreen extends StatefulWidget {
  const PolylineScreen({super.key});

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {

  Completer<GoogleMapController> mainController = Completer();
  CameraPosition initialPosition = CameraPosition(target: LatLng(32.33776386609393, 74.33731717406899),
      zoom: 14);
  List<LatLng> points = [
    LatLng(32.33776386609393, 74.33731717406899), //pickup location
    LatLng(32.32601499987885, 74.38177747027129),
    LatLng(32.353732301270554, 74.36001615939348),
    LatLng(32.300832556093965, 74.35327275041323),//dropoff location
    // LatLng(32.33776386609393, 74.33731717406899),
  ];

Set<Marker> markers = {};
Set<Polyline> polylines = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
for(int i=0;i<points.length;i++){
  markers.add(
    Marker(markerId: MarkerId(i.toString()),position: points[i]
    ,infoWindow: InfoWindow(
          title: i%2==0 ? "A good place to travel" : "A cool place to visit",
          snippet: i%2==0 ?  "5 star ratings" : "Outstanding ratings"
        ),
      icon: BitmapDescriptor.defaultMarker
    )
  );
 polylines.add( Polyline(
     polylineId: PolylineId("1"),
     points: points,
     color: Colors.red,
     geodesic: true,
     startCap: Cap.buttCap,
     endCap: Cap.roundCap,
     width: 4,
   jointType: JointType.bevel
 ));
}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text("Polyline Screen"),
        centerTitle: true,

      ),
      body: GoogleMap(
        initialCameraPosition: initialPosition,
        onMapCreated: (GoogleMapController controller){
          mainController.complete(controller);
        },
        markers: markers,
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        myLocationEnabled: false,
polylines: polylines,
      ),
    );
  }
}

import "dart:collection";

import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "dart:async";
import "dart:ui" as ui;
import "dart:typed_data";
class NetworkImageMarkerScreen extends StatefulWidget {
  const NetworkImageMarkerScreen({super.key});

  @override
  State<NetworkImageMarkerScreen> createState() => _NetworkImageMarkerScreenState();
}

class _NetworkImageMarkerScreenState extends State<NetworkImageMarkerScreen> {

  Completer<GoogleMapController> mainController = Completer();
  CameraPosition initialPosition = CameraPosition(target: LatLng(32.33776386609393, 74.33731717406899),
      zoom: 14);
  Set<Polygon> polygon = HashSet<Polygon>();

  List<Marker> markers = [];
  List<LatLng> lst = [
    LatLng(32.33776386609393, 74.33731717406899),
    LatLng(32.32601499987885, 74.38177747027129),
    LatLng(32.353732301270554, 74.36001615939348),
    LatLng(32.325843970809686, 74.36517004525986),
    LatLng(32.300832556093965, 74.35327275041323),
    LatLng(32.33776386609393, 74.33731717406899),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();

  }

  loadData() async{
    for (int i = 0; i < lst.length; i++) {
      Uint8List? image = await loadNetworkImage("https://cdn-icons-png.flaticon.com/512/744/744465.png");
      final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
        image!.buffer.asUint8List(),
        targetWidth: 100,
        targetHeight: 100,

      );
      final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData = await frameInfo.image.toByteData(
        format: ui.ImageByteFormat.png
      );
      final Uint8List resizedImageMarker = byteData!.buffer.asUint8List(

      );
      markers.add(Marker(
          markerId: MarkerId(i.toString()),
          icon: BitmapDescriptor.fromBytes(resizedImageMarker),
          position: lst[i],
          infoWindow:
          InfoWindow(title: "This is title marker " + (i + 1).toString())));
    }
    for(int i=0;i<lst.length;i++){
      polygon.add(Polygon(polygonId: PolygonId(i.toString()),
        fillColor: Colors.redAccent.withOpacity(0.3),
        geodesic: true,
        points: lst,
        strokeColor: Colors.black,
        strokeWidth: 4
      ));
    }
  }

  Future<Uint8List> loadNetworkImage(String imgPath) async{
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(imgPath);
    image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((info,_)=> completer.complete(info))
    );


    final imageInfo = await completer.future;

    return ((await imageInfo.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: initialPosition,
        markers: Set<Marker>.of(markers),
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

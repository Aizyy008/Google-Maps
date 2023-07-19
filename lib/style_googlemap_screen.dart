import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "dart:async";

class StyleGoogleMapScreen extends StatefulWidget {
  const StyleGoogleMapScreen({super.key});

  @override
  State<StyleGoogleMapScreen> createState() => _StyleGoogleMapScreenState();
}

class _StyleGoogleMapScreenState extends State<StyleGoogleMapScreen> {
  Completer<GoogleMapController> mainController = Completer();
  CameraPosition initialPosition = CameraPosition(
      target: LatLng(32.33776386609393, 74.33731717406899), zoom: 14);
  String maptheme = '';
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

  loadData() async {
    for (int i = 0; i < lst.length; i++) {
      markers.add(Marker(
          markerId: MarkerId(i.toString()),
          icon: BitmapDescriptor.defaultMarker,
          position: lst[i],
          infoWindow:
              InfoWindow(title: "This is title marker " + (i + 1).toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map Styling"),
        centerTitle: true,
        actions: [
          PopupMenuButton(itemBuilder: (context)=>[

            PopupMenuItem(child: Text("Silver Theme"),
            onTap: (){

               mainController.future.then((value){
                 DefaultAssetBundle.of(context)
                     .loadString("assets/maptheme/silver_theme.json")
                     .then((themeValue) {
                   value.setMapStyle(themeValue);
                 });
               });
            },),
            PopupMenuItem(child: Text("Retro Theme"),onTap: (){
              mainController.future.then((value){
                DefaultAssetBundle.of(context)
                    .loadString("assets/maptheme/retro_theme.json")
                    .then((themeValue) {
                  value.setMapStyle(themeValue);
                });
              });
            },),
            PopupMenuItem(child: Text("Night Theme"),onTap: (){
              mainController.future.then((value){
                DefaultAssetBundle.of(context)
                    .loadString("assets/maptheme/night_theme.json")
                    .then((themeValue) {
                  value.setMapStyle(themeValue);
                });
              });
            },)
          ])
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: initialPosition,
        markers: Set<Marker>.of(markers),
        onMapCreated: (GoogleMapController controller) {
          controller.setMapStyle(maptheme);
          mainController.complete(controller);
        },
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
      ),
    );
  }
}

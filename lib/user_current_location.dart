import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "dart:async";
import "package:geolocator/geolocator.dart";

class UserCurrentLocationScreen extends StatefulWidget {
  const UserCurrentLocationScreen({super.key});

  @override
  State<UserCurrentLocationScreen> createState() =>
      _UserCurrentLocationScreenState();
}

class _UserCurrentLocationScreenState extends State<UserCurrentLocationScreen> {
  final Completer<GoogleMapController> controller =  Completer();

  static const CameraPosition location = CameraPosition(
      target: LatLng(32.33531579045427, 74.35289002469037), zoom: 14);

  List<Marker> markers = [];
  List<Marker> list = [
    Marker(
      markerId: MarkerId("1"),
      position: LatLng(32.33531579045427, 74.35289002469037),
    )
  ];
  void initState() {
    super.initState();
    markers.addAll(list);
  }

  Future<Position> getUserCurrentLocation()async{
    await Geolocator.requestPermission().then((value){

    }).onError((error, stackTrace){
      print("Error");
    });

    return await Geolocator.getCurrentPosition();
  }

  // Future<Position> _determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }
  //
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permantly denied, we cannot request permissions.');
  //   }
  //
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission != LocationPermission.whileInUse &&
  //         permission != LocationPermission.always) {
  //       return Future.error(
  //           'Location permissions are denied (actual value: $permission).');
  //     }
  //   }
  //
  //   return await Geolocator.getCurrentPosition();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("User Current Location Screen"),
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: location,
          mapType: MapType.normal,
          compassEnabled: true,
          markers: Set<Marker>.of(markers),
          onMapCreated: (GoogleMapController _controller) {
            controller.complete(_controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getUserCurrentLocation().then((value)async {
            print("My Current Position: " +
                value.latitude.toString() +
                " " +
                value.longitude.toString());
            markers.add(Marker(markerId: MarkerId("3"),
                position: LatLng( value.latitude,
                    value.longitude)));
              CameraPosition cameraPosition = CameraPosition(target: LatLng( value.latitude,
                  value.longitude),zoom: 14);
              final GoogleMapController controller2 = await controller.future;
              controller2.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

              setState(() {

              });
          });

        },
        child: Icon(
          Icons.map,
          color: Colors.black,
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
    );
  }
}

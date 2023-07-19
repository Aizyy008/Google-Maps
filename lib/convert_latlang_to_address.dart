import "package:flutter/material.dart";
import "package:geocoding/geocoding.dart";
import 'package:flutter_geocoder/geocoder.dart';

class ConvertLatLangToAddress extends StatefulWidget {
  const ConvertLatLangToAddress({super.key});

  @override
  State<ConvertLatLangToAddress> createState() =>
      _ConvertLatLangToAddressState();
}

class _ConvertLatLangToAddressState extends State<ConvertLatLangToAddress> {
  String streetAddress = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          title: Text("Google Map"),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  SizedBox(
                    width: 500,
                    height: 100,
                    child: Card(
                      color: Colors.grey,
                      child: Center(child: Text(streetAddress.toString(),textAlign: TextAlign.center,)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                        side: BorderSide(
                          width: 100
                        )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: Center(
                        child: FloatingActionButton(
                          onPressed: () async {
                            final query =
                                "89P3+34Q 89P3+34Q, Sambrial Rd, Mohalla Thathyaran, Daska, Sialkot, Punjab, Pakistan";
                            var addresses =
                                await Geocoder.local.findAddressesFromQuery(query);
                            var second = addresses.first;
                            print("LatLng: " +
                                second.featureName.toString() +
                                " " +
                                second.coordinates.toString());

                            final coordinates = new Coordinates(
                                32.33531579045427, 74.35289002469037);
                            var address = await Geocoder.local
                                .findAddressesFromCoordinates(coordinates);
                            var first = address.first;
                            streetAddress = first.featureName.toString() +
                                " " +
                                first.addressLine.toString();
                            print("Address: " +
                                first.featureName.toString() +
                                " " +
                                first.addressLine.toString());
                          },
                          child: Icon(
                            Icons.change_circle_sharp,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.deepPurple,
                        ),
                      ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

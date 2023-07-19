import "dart:convert";

import "package:flutter/material.dart";
import "package:geocoding/geocoding.dart";
import "package:uuid/uuid.dart";
import 'package:http/http.dart' as http;

class GooglePlacesApiScreen extends StatefulWidget {
  const GooglePlacesApiScreen({super.key});

  @override
  State<GooglePlacesApiScreen> createState() => _GooglePlacesApiScreenState();
}

class _GooglePlacesApiScreenState extends State<GooglePlacesApiScreen> {
  TextEditingController textController = TextEditingController();
  var uuid = Uuid();
  String sessionToken = "1234";
  List<dynamic> placesList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textController.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (sessionToken == null) {
      setState(() {
        sessionToken = uuid.v4();

      });
    }
    getSuggestion(textController.text);//to get response from server

  }

  getSuggestion(String input) async {
    String kPLACES_API_KEY = "AIzaSyAt-VNMbVX5LvWFNBvYAEfmErFEk729-jE";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$sessionToken'; //? for query parameter

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();

    if (response.statusCode ==200 ) {

      setState(() {
        placesList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Places Api"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  hintText: "Search Place",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
Expanded(child: ListView.builder(itemCount: placesList.length,
    itemBuilder: (context, index){
  return ListTile(
    onTap: () async{
      List<Location> locations = await locationFromAddress(placesList[index]['description']);
      print(locations.last.latitude);
      print(locations.last.longitude);
    },
    title: Text(placesList[index]['description']),
  );
    }))
          ],
        ),
      ),
    );
  }
}

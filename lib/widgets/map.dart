
import 'package:flutter/material.dart';
// import 'package:latlong2/latlong.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';
class MapScreen extends StatefulWidget {
String location;
MapScreen(this.location, {super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late List _data;
double latitude=0.0;
double longitude=0.0;
String weburl='';
   getLocationCoordinates() async {
    final url =
        'https://api.opencagedata.com/geocode/v1/json?q=${widget.location}&key=ce938d9725c746ffb05cd5527e68afd1';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedResponse = await json.decode(response.body);
      List<dynamic> results = decodedResponse['results'];
// print(results);
      if (results.isNotEmpty) {
        Map<String, dynamic> firstLocation = results.first;
        Map<String, dynamic> osmInfo = firstLocation['annotations']['OSM'];

        Map<String, dynamic> geometry = firstLocation['geometry'];

        latitude = geometry['lat'];
        longitude = geometry['lng'];
        weburl = osmInfo['url'];


      }
    } else {
      // return 'E';
    }
  }
getLatLong()async{
  await getLocationCoordinates();
  _data =  [
    Model(widget.location, latitude, longitude),
  ];
}

  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: getLatLong(),
      builder: (context,snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          else if(snapshot.hasError){
            return Center(child: Text('${snapshot.error}'),);
          }
        return InkWell(onTap: () async {

         await launchUrl(Uri.parse(weburl));
        },
          child: Container(
            height: 200,
                child: SfMaps(
                  layers: [
                    MapTileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      initialZoomLevel: 10,
                      initialFocalLatLng: MapLatLng(latitude, longitude),
                      initialMarkersCount: 1,
                      markerBuilder: (BuildContext context, int index) {
                        return MapMarker(
                          latitude: _data[index].latitude,
                          longitude: _data[index].longitude,
                          iconColor: Colors.white,
                          iconStrokeColor: Colors.black,
                          iconStrokeWidth: 2,
                        );
                      },
                    ),
                  ],
                ),
              ),
        );
      }
    );
  }
}

class Model {
  const Model(this.country, this.latitude, this.longitude);

  final String country;
  final double latitude;
  final double longitude;
}
import 'dart:async';
import 'dart:developer';
import 'package:contact_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LocationData? myLocation;
  LatLng? selectedLocation;

  Marker? markers;

  getCurrentLocation() async {
    myLocation = await LocationFunctions.getCurrentFunction();
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(myLocation?.latitude ?? 27.6866,
                myLocation?.longitude ?? 83.4323))));
    setState(() {
      markers = markers = LocationFunctions.getMarker(
          "002",
          LatLng(myLocation?.latitude ?? 27.6866,
              myLocation?.longitude ?? 83.4323),
          info: "ram ko location", onLocationSelect: (LatLng loc) {
        selectedLocation = loc;
      });
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          ElevatedButton(onPressed: () {}, child: Text("confirm location")),
      body: Stack(children: [
        Container(
          height: double.maxFinite,
          width: double.maxFinite,
          child: GoogleMap(
            initialCameraPosition:
                CameraPosition(target: LatLng(27.6866, 83.4323), zoom: 18.0),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            mapType: MapType.normal,
            markers: {
              markers != null
                  ? markers!
                  : Marker(
                      markerId: MarkerId("005"),
                      position: LatLng(myLocation?.latitude ?? 27.6866,
                          myLocation?.longitude ?? 83.4323))
            },
            onLongPress: (value) {
              setState(() {
                markers = LocationFunctions.getMarker("002", value,
                    info: "ram ko location", onLocationSelect: (LatLng loc) {
                  selectedLocation = loc;
                });
              });
            },
          ),
        ),
        myLocation == null
            ? Container(
                height: double.maxFinite,
                width: double.maxFinite,
                color: Colors.white,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              )
            : Text("")
      ]),
    );
  }
}

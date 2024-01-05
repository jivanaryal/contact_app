import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationFunctions {
  static Location location = new Location();
  static Future<bool> LocationEnabled() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  static Future<LocationData?> getCurrentFunction() async {
    if (await LocationEnabled()) {
      LocationData currLoc = await location.getLocation();
      return currLoc;
    } else {
      // LocationEnabled();
      return null;
    }
  }

  static Marker getMarker(String markerId, LatLng position,
      {String? info, Function? onLocationSelect}) {
    return Marker(
        markerId: MarkerId(markerId),
        position: position,
        draggable: true,
        infoWindow: info == null
            ? InfoWindow.noText
            : InfoWindow(title: "you are here", snippet: info),
        onDragEnd: (value) {
          if (onLocationSelect != null) {
            onLocationSelect(value);
          }
        });
  }
}

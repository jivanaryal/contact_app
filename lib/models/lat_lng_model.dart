class LatLngModel {
  double latitude;
  double longitude;
  String? address;

  LatLngModel({
    required this.latitude,
    required this.longitude,
    this.address,
  });
}
